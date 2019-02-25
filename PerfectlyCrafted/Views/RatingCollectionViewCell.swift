//
//  RatingCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/7/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
  
  lazy var userDetailsView:UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  let profileImage:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "gift-habeshaw-1217521-unsplash-1"), for: .normal)
    button.clipsToBounds = true
    return button
  }()
  lazy var userName:UILabel = {
    let label = UILabel()
    label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.textColor = .white
    label.text = "iamPowafull"
    label.numberOfLines = 0
    return label
  }()
  lazy var locationLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.textColor = .white
    label.text = "Georgetown,Guyana"
    label.numberOfLines = 0
    return label
  }()
  lazy var productImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "shea")
    return imageView
  }()
  
  lazy var productDetailsView:UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  lazy var ratingOne:UIImageView = {
    let imageView = UIImageView()
   imageView.image = #imageLiteral(resourceName: "icons8-star-filled-25")
    return imageView
  }()
  lazy var ratingTwo:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-star-filled-25")
    return imageView
  }()
  lazy var ratingThree:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-star-filled-25")
    return imageView
  }()
  lazy var ratingFour:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-star-filled-25")
    return imageView
  }()
  lazy var ratingFive:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-star-filled-25")
    return imageView
  }()
  lazy var reviewTextView:UITextView = {
    let textView = UITextView()
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = false
    textView.backgroundColor = .black
    textView.textColor = .white
    textView.text = "Review goes here"
    return textView
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
  super.init(coder: aDecoder)
    commonInit()
  }
  override func layoutSubviews() {
    profileImage.layer.cornerRadius = profileImage.bounds.width/2
    profileImage.layer.borderWidth = 4
    profileImage.layer.borderColor = UIColor.black.cgColor
  }
  func commonInit(){
    setUpViews()
    backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
  }
}
extension RatingCollectionViewCell{
  func setUpViews(){
    setUpUserDetailsView()
    setUpProfileImage()
    setUpUsernameLabel()
    setUpLocationLabel()
    setUpProductImage()
    setupProductDetailedView()
    ratingConstraints()
    setUpReviewTextViewConstraints()
  }
  func ratingConstraints(){
    setUpRatingButtonConstraints()
    ratingTwoConstraints()
    ratingThreeConstraints()
    ratingFourConstraints()
    ratingFiveConstraints()
  }
  func setUpUserDetailsView(){
    addSubview(userDetailsView)
    userDetailsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: userDetailsView, attribute: .top, relatedBy:.equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .trailing, relatedBy: .equal, toItem:safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.09, constant: 35).isActive = true
  }
  func setUpProfileImage(){
    addSubview(profileImage)
    profileImage.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.init(item: profileImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.5, constant: 0).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .width, relatedBy: .equal, toItem: profileImage, attribute: .width, multiplier: 0.1, constant: 60).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 0.1, constant: 60).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .centerX, relatedBy: .equal, toItem: userDetailsView, attribute: .centerX, multiplier: 0.2, constant: 0).isActive = true
    NSLayoutConstraint(item: profileImage, attribute: .centerY, relatedBy: .equal, toItem: userDetailsView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
   
  }
  func setUpUsernameLabel(){
    addSubview(userName)
    userName.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: userName, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.0, constant: 19).isActive = true
    NSLayoutConstraint.init(item: userName, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: userName, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 0.7, constant: 0).isActive = true
  }
  func setUpLocationLabel(){
    addSubview(locationLabel)
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: locationLabel, attribute: .top, relatedBy: .equal, toItem: userName, attribute: .top, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: locationLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: locationLabel, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 0.7, constant: 0).isActive = true
  }
  func setUpProductImage(){
    addSubview(productImage)
    productImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: productImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .bottom, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: productImage, attribute: .width, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
    NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
    NSLayoutConstraint.init(item: productImage, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 80).isActive = true
  }
  func setupProductDetailedView(){
    addSubview(productDetailsView)
    productDetailsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: productDetailsView, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: productDetailsView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: productDetailsView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: productDetailsView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpRatingButtonConstraints(){
    addSubview(ratingOne)
    ratingOne.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingOne, attribute: .top, relatedBy: .equal, toItem: productDetailsView, attribute: .top, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 120).isActive = true
  }
  func ratingTwoConstraints() {
    addSubview(ratingTwo)
    ratingTwo.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingTwo, attribute: .top, relatedBy: .equal, toItem: productDetailsView, attribute: .top, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .leading, relatedBy: .equal, toItem: ratingOne, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  
  func ratingThreeConstraints() {
    addSubview(ratingThree)
    ratingThree.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingThree, attribute: .top, relatedBy: .equal, toItem: productDetailsView, attribute: .top, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .leading, relatedBy: .equal, toItem: ratingTwo, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func ratingFourConstraints() {
    addSubview(ratingFour)
    ratingFour.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingFour, attribute: .top, relatedBy: .equal, toItem: productDetailsView, attribute: .top, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .leading, relatedBy: .equal, toItem: ratingThree, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func ratingFiveConstraints() {
    addSubview(ratingFive)
    ratingFive.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingFive, attribute: .top, relatedBy: .equal, toItem: productDetailsView, attribute: .top, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .leading, relatedBy: .equal, toItem: ratingFour, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func setUpReviewTextViewConstraints(){
    addSubview(reviewTextView)
    reviewTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: reviewTextView, attribute: .top, relatedBy: .equal, toItem: ratingOne, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: reviewTextView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: reviewTextView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: reviewTextView, attribute: .bottom, relatedBy: .equal, toItem: productDetailsView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
  }
  
}
