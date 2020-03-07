//
//  PostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher

class PostViewController: UIViewController {
    
    @IBOutlet private weak var feedsCollectionView: UICollectionView!
    
    private let postCollectionViewDataSource = PostsCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        feedsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        feedsCollectionView.dataSource = postCollectionViewDataSource
        feedsCollectionView.reloadData()
    }
}
