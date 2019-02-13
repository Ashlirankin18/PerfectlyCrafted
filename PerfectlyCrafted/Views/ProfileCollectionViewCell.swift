//
//  ProfileCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/6/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
  lazy var cellBackgroundImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "placeholder")
    return imageView
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    //backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    setupViews()
  }
  
}
extension ProfileCollectionViewCell {
  private func setupViews(){
    setupImageViewConstraints()
  }
  func setupImageViewConstraints(){
    addSubview(cellBackgroundImage)
cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 0, constant: 8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -8).isActive = true
    
  }
}
