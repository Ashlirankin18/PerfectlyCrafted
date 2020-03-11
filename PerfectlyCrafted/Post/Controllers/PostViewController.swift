//
//  PostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

/// `UIViewController` subclass which displays posts.
final class PostViewController: UIViewController {
    
    @IBOutlet private weak var postsCollectionView: UICollectionView!
    
    private let persistenceController: PersistenceController
    private let localImageManager = try! LocalImageManager()
    private var fetchResultsController: NSFetchedResultsController<Post>?
    
    // We are using the currently selected index path to check if the post is being edited or inserted for the first time.
    private var currentlySelectedIndexPath: IndexPath?
    
    private lazy var cardViewControllerTransitioningDelegate = CardPresentationManager()
    
    private lazy var postCollectionViewDataSource: PostsCollectionViewDataSource = {
        let postDataSource = PostsCollectionViewDataSource(collectionView: postsCollectionView) { (collectionView, indexPath, post) -> UICollectionViewCell in
            self.configureCell(collectionView: collectionView, indexPath: indexPath, post: post)
        }
        postsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        return postDataSource
    }()
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(sender:)))
    
    /// Creates a new instance of `PostViewController`.
    /// - Parameters:
    ///   - coder: An archiver.
    ///   - persistenceController: The persistence controller.
    init?(coder: NSCoder, persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()
        configureFetchResultsController()
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
    }
    
    private func configureCell (collectionView: UICollectionView, indexPath: IndexPath, post: Post ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        configureCellViewModel(cell: cell, post: post)
        
        cell.editButtonTapped = { [weak self] in
            self?.currentlySelectedIndexPath = indexPath
            self?.presentAlertController(indexPath: indexPath)
        }
        return cell
    }
    
    private func configureCellViewModel(cell: PostCollectionViewCell, post: Post) {
        
        if let photoIdentifier = post.photoIdentfier {
            localImageManager.loadImage(forKey: photoIdentifier) { (result) in
                switch result {
                case let .success(image):
                    cell.viewModel = PostCollectionViewCell.ViewModel(postImage: image, title: post.title ?? "", description: post.postDescription ?? "", date: post.date!)
                case let .failure(error):
                    print("There was an error \(error)")
                }
            }
        } else {
            cell.viewModel = PostCollectionViewCell.ViewModel(postImage: nil, title: post.title ?? "", description: post.postDescription ?? "", date: post.date!)
        }
    }
    
    private func configureFetchResultsController() {
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistenceController.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController?.delegate = self
        
        do {
            try fetchResultsController?.performFetch()
            if let posts = fetchResultsController?.fetchedObjects {
                updateDataSource(items: posts)
                
                //TODO: - HANDLE THE EMPTY STATE OF NOT HAVING ENTRIES.
            }
        } catch {
            print(error)
        }
    }
    
    
    private func updateDataSource(items: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<PostsCollectionViewDataSource.Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        postCollectionViewDataSource.updateSnapshot(snapshot)
    }
    
    private func presentAlertController(indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Options", message: "What would you like to do?", preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit Post", style: .default) { [weak self] _ in
            guard let posts = self?.fetchResultsController?.fetchedObjects, let self = self else {
                return
            }
            guard let postId = posts[indexPath.row].id else {
                return
            }
        
            let editPostViewController = EditPostViewController(postId: postId, persistenceController: self.persistenceController, localImageManager: self.localImageManager)
            let editControllerNavigationController = UINavigationController(rootViewController: editPostViewController)
             editControllerNavigationController.modalPresentationStyle = .custom
            editControllerNavigationController.transitioningDelegate = self.cardViewControllerTransitioningDelegate
            self.show(editControllerNavigationController, sender: self)
        }
        
        let shareAction = UIAlertAction(title: "Share Post", style: .default) { _ in
            print("Share")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(shareAction)
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    
    @objc private func addButtonTapped(sender: UIBarButtonItem) {
        let addPostViewController = AddPostViewController(postId: UUID(), persistenceController: persistenceController)
        let addPostNavigationController = UINavigationController(rootViewController: addPostViewController)
        show(addPostNavigationController, sender: self)
    }
    
}

extension PostViewController: NSFetchedResultsControllerDelegate {
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let indexPath = currentlySelectedIndexPath, let post = controller.object(at: indexPath) as? Post {
            postCollectionViewDataSource.reload(item: post)
        } else {
            if let posts = controller.fetchedObjects as? [Post] {
                updateDataSource(items: posts)
            } else {
                print("No object found")
            }
        }
        
        if persistenceController.mainContext.hasChanges {
            persistenceController.saveContext()
        } 
    }
}
