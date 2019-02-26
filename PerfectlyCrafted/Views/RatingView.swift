//
//  RatingView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/7/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class RatingView: UIView {
  weak var delegate: RatingCollectionViewCell?
  
  lazy var ratingCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: "RatingCell")
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    setUpViews()
    
  }
  
}
  
extension RatingView{
  func setUpViews(){
 
   setUpCollectionView()
  }
  
  func setUpCollectionView(){
    
     setUpCollectionViewConstraints()
  }

  func setUpCollectionViewConstraints() {
    addSubview(ratingCollectionView)
    ratingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 2).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
}


