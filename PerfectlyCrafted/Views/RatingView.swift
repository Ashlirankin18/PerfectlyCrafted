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
    collectionView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    return collectionView
  }()
  lazy var categoriesControl:UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    segmentedControl.insertSegment(withTitle: "Accessories", at: 0, animated: true)
    
    segmentedControl.insertSegment(withTitle: "HairCare", at: 1, animated: true)
    segmentedControl.insertSegment(withTitle: "HairTools", at:2, animated: true)
     segmentedControl.addTarget(self, action: #selector(switchView), for: .valueChanged)
    return segmentedControl
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
    categoriesControl.selectedSegmentIndex = 0
  }
  
  @objc func switchView(){
    switch categoriesControl.selectedSegmentIndex {
    case 0:
    print("a")
    case 1:
      print("hair care")
    case 2:
      print("hair tools")
    default:
      print("d")
    }
  }
}
  
extension RatingView{
  func setUpViews(){
 
   setUpCollectionView()
  }
  func setUpCollectionView(){
       setUpSegmentedControl()
     setUpCollectionViewConstraints()
  }
  func setUpSegmentedControl(){
    addSubview(categoriesControl)
    categoriesControl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: categoriesControl, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: categoriesControl, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: categoriesControl, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpCollectionViewConstraints() {
    addSubview(ratingCollectionView)
    ratingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .top, relatedBy: .equal, toItem: categoriesControl, attribute: .bottom, multiplier: 1.0, constant: 2).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingCollectionView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
}


