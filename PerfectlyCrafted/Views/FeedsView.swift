//
//  FeedsView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/6/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class FeedsView: UIView {
  
  lazy var feedsCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    collectionView.register(FeedsCollectionViewCell.self, forCellWithReuseIdentifier: "FeedsCell")
    collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
  private func commonInit(){
    setUpViews()
    backgroundColor = .white
  }

}
extension FeedsView{
 private func setUpViews(){
    setUpCollectionView()
  }
  private func setUpCollectionView(){
    setUpCollectionViewConstraints()
  }
  
 private func setUpCollectionViewConstraints() {
    addSubview(feedsCollectionView)
    feedsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: feedsCollectionView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: feedsCollectionView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: feedsCollectionView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: feedsCollectionView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
}
