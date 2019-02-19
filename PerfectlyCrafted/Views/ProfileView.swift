//
//  ProfileView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/6/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ProfileView: UIView {
  lazy var bioView:UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
 lazy var profileImage:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "gift-habeshaw-1217521-unsplash-1"), for: .normal)
    button.clipsToBounds = true
    button.layer.masksToBounds = true
    return button
  }()
  
  lazy var dividerView:UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  lazy var profileCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    
    collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCell")
    collectionView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    return collectionView
  }()
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  override func layoutSubviews() {
    profileImage.layer.cornerRadius = profileImage.bounds.width/2
    profileImage.layer.borderWidth = 4
    profileImage.layer.borderColor = UIColor.black.cgColor
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    setUpViews()
  }
  
}
extension ProfileView{
  func setUpViews(){
      setUpBioView()
     setupProfileImage()
    setUpDividerView()
    setUpCollectionViewConstraints()
   
  }
  func setUpBioView(){
    addSubview(bioView)
    bioView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: bioView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: bioView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: bioView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: bioView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.25, constant: 0).isActive = true
  }
  func setUpCollectionViewConstraints() {
    addSubview(profileCollectionView)
    profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: profileCollectionView, attribute: .top, relatedBy: .lessThanOrEqual, toItem: bioView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: profileCollectionView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: profileCollectionView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: profileCollectionView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  func setupProfileImage(){
    addSubview(profileImage)
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: bioView, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .width, relatedBy: .equal, toItem: bioView, attribute: .width, multiplier: 0.1, constant: 44).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .height, relatedBy: .equal, toItem: bioView, attribute: .height, multiplier: 0.4, constant: 44).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
  }
  func setUpDividerView(){
    addSubview(dividerView)
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
}
