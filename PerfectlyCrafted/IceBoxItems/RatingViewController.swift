//
//  RatingViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/7/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

  let ratingView = RatingView()
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
      view.addSubview(ratingView)
      ratingView.ratingCollectionView.delegate = self
      ratingView.ratingCollectionView.dataSource = self
    
    }
 
}
extension RatingViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 400, height: 600)
  }
}
extension RatingViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = ratingView.ratingCollectionView.dequeueReusableCell(withReuseIdentifier: "RatingCell", for: indexPath) as? RatingCollectionViewCell else {fatalError("No cell rating found")}
    return cell
  }
  
  
}

