//
//  PostsCollectionViewDataSource.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 10/13/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

/// The data source of the `PostCollectionView`.
final class PostsCollectionViewDataSource: NSObject {
   
    enum Section {
       case main
    }
    
    typealias CellConfiguration = (UICollectionView, IndexPath, Post) -> UICollectionViewCell
    
    private let cellConfiguration: CellConfiguration
    
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
    
    /// Creates a new instance of `PostsCollectionViewDataSource`
    /// - Parameters:
    ///   - collectionView: The collection view
    ///   - cellConfiguration: the cell configuration
    init(collectionView: UICollectionView, cellConfiguration: @escaping CellConfiguration) {
        self.collectionView = collectionView
        self.cellConfiguration = cellConfiguration
    }
    
    /// Updates the data source's snapshot.
    /// - Parameter snapshot: The snapshot.
    func updateSnapshot(_ snapshot: NSDiffableDataSourceSnapshot<Section, Post>) {
        dataSource?.apply(snapshot)
    }
    
    
}
