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
    view.backgroundColor = .gray
    return view
  }()
  lazy var userName: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.font = UIFont(name: "Helvetica", size: 16)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .justified
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  lazy var hairType: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.font = UIFont(name: "Helvetica", size: 14)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .justified
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  lazy var aboutMeTextView:UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.font = UIFont(name: "Helvetica", size: 12)
    textView.textAlignment = .justified
    textView.isEditable = false
    textView.isScrollEnabled = false
    return textView
  }()
  lazy var profileCollectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    
    collectionView.register(FeedsCollectionViewCell.self, forCellWithReuseIdentifier: "FeedsCell")
    collectionView.backgroundColor = .white
    
    return collectionView
  }()
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    profileImage.layer.cornerRadius = profileImage.bounds.width/2
    profileImage.layer.borderWidth = 4
    profileImage.layer.borderColor = UIColor.black.cgColor
    userName.layer.cornerRadius = 8
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    backgroundColor = UIColor.lightGray
    setUpViews()
    bioView.layer.cornerRadius = 10
    bioView.layer.borderColor = UIColor.lightGray.cgColor
    bioView.layer.borderWidth = 4
    profileCollectionView.layer.cornerRadius = 10
    profileCollectionView.layer.borderWidth = 4
    profileCollectionView.layer.borderColor = UIColor.lightGray.cgColor
  }
  
}
extension ProfileView{
  func setUpViews(){
    setUpBioView()
    setupProfileImage()
    setUpDividerView()
    setUpCollectionViewConstraints()
    setUpUserNameLabel()
    setUpHairtypeLabel()
    setUpAboutMeLabel()
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
    NSLayoutConstraint(item: profileImage, attribute: .centerY, relatedBy: .equal, toItem: bioView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .width, relatedBy: .equal, toItem: profileImage, attribute: .width, multiplier: 0.4, constant: 60).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 0.4, constant: 60).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
  }
  func setUpDividerView(){
    addSubview(dividerView)
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImage.trailingAnchor, multiplier: 1.3).isActive = true
    dividerView.widthAnchor.constraint(equalToConstant: 3).isActive = true
    dividerView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    dividerView.centerYAnchor.constraint(equalTo: bioView.centerYAnchor, constant: 0).isActive = true
    
  }
  func setUpUserNameLabel(){
    addSubview(userName)
    userName.translatesAutoresizingMaskIntoConstraints = false
    userName.topAnchor.constraint(equalToSystemSpacingBelow: bioView.topAnchor, multiplier: 3.5).isActive = true
    userName.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 1.4).isActive = true
    userName.widthAnchor.constraint(equalToConstant: 200).isActive = true
   
  }
  func setUpHairtypeLabel(){
    addSubview(hairType)
    hairType.translatesAutoresizingMaskIntoConstraints = false
    hairType.topAnchor.constraint(equalToSystemSpacingBelow: userName.bottomAnchor, multiplier: 1.8).isActive = true
    hairType.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 1.4).isActive = true
    hairType.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
  }
  func setUpAboutMeLabel(){
    addSubview(aboutMeTextView)
    aboutMeTextView.translatesAutoresizingMaskIntoConstraints = false
    aboutMeTextView.topAnchor.constraint(equalToSystemSpacingBelow: hairType.bottomAnchor, multiplier: 1.4).isActive = true
    aboutMeTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 1.2).isActive = true
    aboutMeTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    aboutMeTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
  }
  
}
