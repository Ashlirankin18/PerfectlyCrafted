//
//  PostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher

/// `UIViewController` subclass which displays posts.
final class PostViewController: UIViewController {
    
    @IBOutlet private weak var feedsCollectionView: UICollectionView!
    
    private let postCollectionViewDataSource = PostsCollectionViewDataSource()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        feedsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        feedsCollectionView.dataSource = postCollectionViewDataSource
        postCollectionViewDataSource.delegate = self
        feedsCollectionView.reloadData()
    }
    
    private func performFetchRequest() {
       // ll load items
        
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
    }
    
    @objc private func addButtonTapped(sender: UIBarButtonItem) {
        let addPostViewController = AddPostViewController(nibName: "AddPostViewController", bundle: Bundle.main)
        present(addPostViewController, animated: true)
    }
}

extension PostViewController : PostsCollectionViewDataSourceDelegate {
 
    //MARK: - PostsCollectionViewDataSourceDelegate
    
    func postCellEditButtonTapped(_ cell: PostCollectionViewCell, indexPath: IndexPath) {
        print("Tapped: \(indexPath.row)")
    }
}
