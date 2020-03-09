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

    private lazy var postCollectionViewDataSource: PostsCollectionViewDataSource = {
        let postDataSource = PostsCollectionViewDataSource(collectionView: postsCollectionView) { (collectionView, indexPath, post) -> UICollectionViewCell in
            self.configureCell(collectionView: collectionView, indexPath: indexPath, posts: post)
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
    
    private func configureCell (collectionView: UICollectionView, indexPath: IndexPath, posts: Post ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.editButtonTapped = {
            print("edit button tapped.")
        }
        return cell
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
            }
        } catch {
          print(error)
        }
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
    }
    
    @objc private func addButtonTapped(sender: UIBarButtonItem) {
        let addPostViewController = AddPostViewController(postId: UUID(), persistenceController: persistenceController)
        present(addPostViewController, animated: true)
    }
    
    func updateDataSource(items: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<PostsCollectionViewDataSource.Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        postCollectionViewDataSource.updateSnapshot(snapshot)
    }
}

extension PostViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let posts = controller.fetchedObjects as? [Post] {
            updateDataSource(items: posts)
        } else {
            print("No object found")
        }
        if persistenceController.mainContext.hasChanges {
            persistenceController.saveContext()
        }
    }
}
