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
    private let localImageManager = try? LocalImageManager()
    private var fetchResultsController: NSFetchedResultsController<Post>?
    
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
        postsCollectionView.delegate = self
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
            self?.presentAlertController(post: post)
        }
        return cell
    }
    
    private func configureCellViewModel(cell: PostCollectionViewCell, post: Post) {
        
        if let photoIdentifier = post.photoIdentfier {
            localImageManager?.loadImage(forKey: photoIdentifier) { (result) in
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
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistenceController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
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
    
    private func presentAlertController(post: Post) {
        
        let alertController = UIAlertController(title: "Options", message: "What would you like to do?", preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit Post", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            let editPostViewController = EditPostViewController(post: post, persistenceController: self.persistenceController)
            let editControllerNavigationController = UINavigationController(rootViewController: editPostViewController)
            editControllerNavigationController.modalPresentationStyle = .custom
            editControllerNavigationController.transitioningDelegate = self.cardViewControllerTransitioningDelegate
            self.show(editControllerNavigationController, sender: self)
        }
        
        let shareAction = UIAlertAction(title: "Share Post", style: .default) { [weak self] _ in
            let shareViewController = PostShareViewController(post: post)
            let shareNavigationController = UINavigationController(rootViewController: shareViewController)
            self?.show(shareNavigationController, sender: self)
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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .update:
            guard let post = anObject as? Post else {
                return
            }
            postCollectionViewDataSource.reload(item: post)
        case .insert, .move, .delete:
            guard let posts = controller.fetchedObjects as? [Post] else {
                return
            }
            updateDataSource(items: posts)
        default:
            logAssertionFailure(message: "An unknown case was not handled.")
        }
    }
}

extension PostViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 2)
    }
}
