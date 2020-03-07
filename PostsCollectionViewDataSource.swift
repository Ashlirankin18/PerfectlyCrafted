//
//  PostsCollectionViewDataSource.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 10/13/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

final class PostsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var posts: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCollectionViewCell else {fatalError("No feed cell was found")}
        return cell
    }
}
