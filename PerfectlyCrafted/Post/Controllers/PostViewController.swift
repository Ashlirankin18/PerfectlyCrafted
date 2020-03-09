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
    
    @IBOutlet private weak var feedsCollectionView: UICollectionView!
    
    private let postCollectionViewDataSource = PostsCollectionViewDataSource()
    
    private let persistenceController: PersistenceController
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(sender:)))
    
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
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedsCollectionView.reloadData()
    }
    
    private func configureCollectionView() {
        feedsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        feedsCollectionView.dataSource = postCollectionViewDataSource
        postCollectionViewDataSource.delegate = self
        performFetchRequest()
    }
    
    private func performFetchRequest() {
       // ll load items
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            let posts = try persistenceController.mainContext.fetch(request)
        postCollectionViewDataSource.posts = posts
        feedsCollectionView.reloadData()
        } catch {
            print("Error fetching data from context")
        }
        
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
    }
    
    @objc private func addButtonTapped(sender: UIBarButtonItem) {
        let addPostViewController = AddPostViewController(postId: UUID(), persistenceController: persistenceController)
        present(addPostViewController, animated: true)
    }
}

extension PostViewController : PostsCollectionViewDataSourceDelegate {
 
    //MARK: - PostsCollectionViewDataSourceDelegate
    
    func postCellEditButtonTapped(_ cell: PostCollectionViewCell, indexPath: IndexPath) {
        print("Tapped: \(indexPath.row)")
    }
}
