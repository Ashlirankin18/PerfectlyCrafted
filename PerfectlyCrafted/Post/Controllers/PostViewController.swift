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
final class PostViewController: UICollectionViewController {
    
    private let persistenceController: PersistenceController
    private let localImageManager = try? LocalImageManager()
    private var fetchResultsController: NSFetchedResultsController<Post>?
    
    private lazy var transitionDelegate: CardPresentationManager = CardPresentationManager()
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(sender:)))
    
    private lazy var settingsBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped(sender:)))
    
    private lazy var longPressPressGestureRecognizer: UILongPressGestureRecognizer = {
        let longPressPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLogPress(_:)))
        longPressPressGestureRecognizer.minimumPressDuration = 0.5
        longPressPressGestureRecognizer.delaysTouchesBegan = true
        longPressPressGestureRecognizer.delegate = self
        return longPressPressGestureRecognizer
    }()
    
    private var posts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        collectionView.dataSource = self
        configureFetchResultsController()
        title = "My Entries"
        
        collectionView.addGestureRecognizer(longPressPressGestureRecognizer)
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
        navigationItem.leftBarButtonItem = settingsBarButtonItem
    }
    
    private func configureCellViewModel(cell: PostCollectionViewCell, post: Post) {
        
        if let photoIdentifier = post.photoIdentfier, let createdDate = post.createdDate {
            localImageManager?.loadImage(forKey: photoIdentifier) { (result) in
                switch result {
                case let .success(image):
                    cell.viewModel = PostCollectionViewCell.ViewModel(postImage: image, title: post.title?.capitalized ?? "", date: post.eventDate ?? createdDate)
                case let .failure(error):
                    print("There was an error \(error)")
                }
            }
        } else {
            guard let createdDate = post.createdDate else {
                return
            }
            cell.viewModel = PostCollectionViewCell.ViewModel(postImage: nil, title: post.title?.capitalized ?? "", date: post.eventDate ?? createdDate)
        }
    }
    
    private func configureFetchResultsController() {
        
        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: false)
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistenceController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController?.delegate = self
        
        do {
            try fetchResultsController?.performFetch()
            if let posts = fetchResultsController?.fetchedObjects {
                self.posts = posts
                
                //TODO: - HANDLE THE EMPTY STATE OF NOT HAVING ENTRIES.
            }
        } catch {
            print(error)
        }
    }
    
    private func presentAlertController(post: Post) {
        
        let alertController = UIAlertController(title: "Options", message: "What would you like to do?", preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit Post", style: .default) { [weak self] _ in
            guard let self = self, let id = post.id else {
                return
            }
            
            let addPostViewController = AddPostViewController(postId: id, persistenceController: self.persistenceController, contentState: .editing)
            let addPostNavigationController = UINavigationController(rootViewController: addPostViewController)
            self.show(addPostNavigationController, sender: self)
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
        let addPostViewController = AddPostViewController(postId: UUID(), persistenceController: persistenceController, contentState: .creating)
        let addPostNavigationController = UINavigationController(rootViewController: addPostViewController)
        show(addPostNavigationController, sender: self)
    }
    
    @objc private func settingsButtonTapped(sender: UIBarButtonItem) {
        let settingsViewController = UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController")
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        show(settingsNavigationController, sender: self)
    }
    
    @objc private func handleLogPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.ended {
            return
        }
        let p = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: p)
        if let index = indexPath {
            let post = posts[index.row]
            presentAlertController(post: post)
        } else {
            print("Could not find index path")
        }
    }
}

extension PostViewController: NSFetchedResultsControllerDelegate {
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .update:
            collectionView.reloadItems(at: [newIndexPath!])
        case .insert, .move, .delete:
            guard let posts = controller.fetchedObjects as? [Post] else {
                return
            }
            self.posts = posts
        default:
            logAssertionFailure(message: "An unknown case was not handled.")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = posts[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        configureCellViewModel(cell: cell, post: post)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let layout = collectionViewLayout as? FeaturedLayout else {
            return
        }
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        let post = posts[indexPath.row]
        let detailledController = UIStoryboard(name: "Detailed", bundle: Bundle.main).instantiateViewController(identifier: "DetailedViewController", creator: { coder in
            return DetailedViewController(coder: coder, post: post)
            })
        detailledController.modalPresentationStyle = .fullScreen
        present(detailledController, animated: true)
    }
}

extension PostViewController: UIGestureRecognizerDelegate {}
