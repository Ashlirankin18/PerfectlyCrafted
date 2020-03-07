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
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        feedsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        feedsCollectionView.dataSource = postCollectionViewDataSource
        feedsCollectionView.reloadData()
    }
    
    private func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = addPostBarButtonItem
    }
    
    @objc private func addButtonTapped(sender: UIBarButtonItem) {
        let addPostViewController = AddPostViewController(nibName: "AddPostViewController", bundle: Bundle.main)
        present(addPostViewController, animated: true)
    }
}
