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

    private lazy var addPostBarButtonItem: UIBarButtonItem = {
        let button = CircularButton.addButton
        button.buttonTapped = { [weak self] button in
            
            guard let self = self else {
                return
            }
            
            let addPostViewController = UIStoryboard(name: "AddPost", bundle: Bundle.main).instantiateViewController(identifier: "AddPostViewController", creator: { coder in
                return AddPostViewController(coder: coder, postId: UUID(), persistenceController: self.persistenceController, contentState: .creating)
            })
            
            let addPostNavigationController = UINavigationController(rootViewController: addPostViewController)
            addPostNavigationController.modalPresentationStyle = .fullScreen
            self.show(addPostNavigationController, sender: self)
        }
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var settingsBarButtonItem: UIBarButtonItem = {
        let button = CircularButton.settingsButton
        button.buttonTapped = { [weak self] button in
            guard let self = self else {
                return
            }
            let settingsViewController = UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController")
            let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
            self.show(settingsNavigationController, sender: self)
        }
        return UIBarButtonItem(customView: button)
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
        configureNavigationBar()
        configureBarButtonItem()
        collectionView.dataSource = self
        configureFetchResultsController()
        title = "My Entries"
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
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
            return DetailedViewController(coder: coder, post: post, persistenceController: self.persistenceController)
        })
        let detailledNavigationController = UINavigationController(rootViewController: detailledController)
        detailledNavigationController.modalPresentationStyle = .fullScreen
        present(detailledNavigationController, animated: true)
    }
}

extension PostViewController: NSFetchedResultsControllerDelegate {
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .update:
            guard let indexPath = newIndexPath else {
                return
            }
            collectionView.reloadItems(at: [indexPath])
        case .insert, .move, .delete:
            guard let posts = controller.fetchedObjects as? [Post] else {
                return
            }
            self.posts = posts
        default:
            logAssertionFailure(message: "An unknown case was not handled.")
        }
    }
}
