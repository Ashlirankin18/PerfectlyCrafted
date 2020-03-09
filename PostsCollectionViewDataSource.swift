//
//  PostsCollectionViewDataSource.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 10/13/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

final class PostsCollectionViewDataSource: NSObject {
    enum Section {
       case main
    }
    
    typealias CellConfiguration = (UICollectionView, IndexPath, Post) -> UICollectionViewCell
    
    let cellConfiguration: CellConfiguration
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Post>? = {
        
        guard let collectionView = collectionView else {
            return nil
        }
        let dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: collectionView) { (collectionView, indexPath, post) -> UICollectionViewCell? in
            self.cellConfiguration(collectionView, indexPath, post)
        }
        return dataSource
    }()
    
    private weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView, cellConfiguration: @escaping CellConfiguration) {
        self.collectionView = collectionView
        self.cellConfiguration = cellConfiguration
    }
    
    func updateSnapshot(_ snapshot: NSDiffableDataSourceSnapshot<Section, Post>) {
        dataSource?.apply(snapshot)
    }
    
    
}
