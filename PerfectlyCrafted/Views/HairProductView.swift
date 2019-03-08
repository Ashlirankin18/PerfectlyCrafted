//
//  HairProductView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class HairProductView: UIView {
  lazy var backgroundImage:UIImageView = {
    let imageView = UIImageView()
    
    imageView.image = #imageLiteral(resourceName: "accessories-afro-beautiful-935985")
    return imageView
  }()
  lazy var productDisplayView:UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.masksToBounds = true
    view.backgroundColor = #colorLiteral(red: 0.7452807741, green: 0.7452807741, blue: 0.7452807741, alpha: 0.8373555223)
    
    return view
  }()
  lazy var productCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
    collectionView.backgroundColor = .clear
    collectionView.layer.cornerRadius = 10
    collectionView.layer.masksToBounds = true
    return collectionView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
extension HairProductView{
  func setUpViews(){
   setUpBackgroundImageConstraints()
    setUpProductDisplayView()
    setCollectionViewConstraints()
   
  }
  func setUpBackgroundImageConstraints(){
     addSubview(backgroundImage)
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: backgroundImage, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: backgroundImage, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: backgroundImage, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: backgroundImage, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    
  }
  func setUpProductDisplayView(){
    addSubview(productDisplayView)
    productDisplayView.translatesAutoresizingMaskIntoConstraints = false
   NSLayoutConstraint(item: productDisplayView, attribute: .top, relatedBy: .equal, toItem: backgroundImage, attribute: .top, multiplier: 1.0, constant: 30).isActive = true
   NSLayoutConstraint(item: productDisplayView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImage, attribute: .bottom, multiplier: 1.0, constant: -30).isActive = true
   NSLayoutConstraint(item: productDisplayView, attribute: .leading, relatedBy: .lessThanOrEqual, toItem: backgroundImage, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
   NSLayoutConstraint(item: productDisplayView, attribute: .trailing, relatedBy: .equal, toItem: backgroundImage, attribute: .trailing, multiplier: 1.0, constant: -30).isActive = true
  }
  func setCollectionViewConstraints(){
    addSubview(productCollectionView)
    productCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item:  productCollectionView, attribute: .top, relatedBy: .equal, toItem: productDisplayView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item:  productCollectionView, attribute: .bottom, relatedBy: .equal, toItem: productDisplayView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item:  productCollectionView, attribute: .leading, relatedBy: .equal, toItem: productDisplayView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item:  productCollectionView, attribute: .trailing, relatedBy: .equal, toItem: productDisplayView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
    
  
  
}
