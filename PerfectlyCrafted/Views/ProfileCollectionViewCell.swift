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
    imageView.image = #imageLiteral(resourceName: "hairJournal")
    return imageView
  }()
  lazy var collectionLabel:UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.backgroundColor = .clear
    label.text = "Hair Regimein"
    label.textAlignment = .center
    label.font = UIFont.init(name: "Helvetica", size: 24.0)
    return label
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
    setupViews()
    self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
  override func layoutSubviews() {
    layer.cornerRadius = 10
    cellBackgroundImage.layer.cornerRadius = 6
    cellBackgroundImage.layer.masksToBounds = true
    cellBackgroundImage.layer.borderColor = UIColor.lightGray.cgColor
    cellBackgroundImage.layer.borderWidth = 4
  }
}
extension ProfileCollectionViewCell {
  private func setupViews(){
    setupImageViewConstraints()
    setUpLabel()
  }
  func setupImageViewConstraints(){
    addSubview(cellBackgroundImage)
cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint(item: cellBackgroundImage, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -8).isActive = true
    
  }
  func setUpLabel(){
    addSubview(collectionLabel)
    collectionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: collectionLabel, attribute: .centerX, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: collectionLabel, attribute: .centerY, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerY , multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: collectionLabel, attribute: .leading, relatedBy: .equal, toItem: cellBackgroundImage, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint(item: collectionLabel, attribute: .trailing, relatedBy: .equal, toItem: cellBackgroundImage, attribute: .trailing, multiplier: 1.0, constant: -8).isActive = true
  }
}
