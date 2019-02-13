//
//  FeedsCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/6/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class FeedsCollectionViewCell: UICollectionViewCell {
  
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
  lazy var postImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "bobby-rodriguezz-617687-unsplash-3")
    return imageView
  }()
  lazy var commentsAndLikeView:UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  lazy var likeButton:UIButton = {
    let button = UIButton()
   button.setImage(#imageLiteral(resourceName: "icons8-heart-outline-25"), for: .normal)
    return button
  }()
  lazy var commentButton:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "icons8-speech-bubble-25"), for: .normal)
    return button
  }()
  lazy var shareButton:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "icons8-share-25.png"), for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
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
    backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    setUpViews()
  }
}
extension FeedsCollectionViewCell{
  func setUpViews(){
    setUpUserDetailsView()
    setUpProfileImage()
    setUpUsernameLabel()
    setUpLocationLabel()
    setUpPostImageConstraints()
    setUpCommentsandLikesView()
    setUpLikeButtonConstraints()
    setUpCommentButtonConstraints()
    shareButtonConstraints()
  }
  
  func setUpUserDetailsView(){
    addSubview(userDetailsView)
userDetailsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: userDetailsView, attribute: .top, relatedBy:.equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .trailing, relatedBy: .equal, toItem:safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.10, constant: 30).isActive = true
  }
  func setUpProfileImage(){
    addSubview(profileImage)
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: profileImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .width, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .width, multiplier: 0.1, constant: 40).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .height, relatedBy: .equal, toItem: userDetailsView, attribute: .height, multiplier: 0.4, constant: 40).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: userDetailsView, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
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
  func setUpPostImageConstraints(){
    addSubview(postImage)
    postImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: postImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .leading, relatedBy: .equal, toItem: userDetailsView, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0.89, constant: -20).isActive = true
  }
  func setUpCommentsandLikesView(){
    addSubview(commentsAndLikeView)
    commentsAndLikeView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .top, relatedBy:.equal, toItem: postImage, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .trailing, relatedBy: .equal, toItem:safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.111, constant: 10).isActive = true
}
  func setUpLikeButtonConstraints(){
    addSubview(likeButton)
    likeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: likeButton, attribute: .top, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint(item: likeButton, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .leading, multiplier: 1.0, constant: -20).isActive = true
    NSLayoutConstraint(item: likeButton, attribute: .width, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    
    
  }
  func setUpCommentButtonConstraints(){
    addSubview(commentButton)
    commentButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: commentButton, attribute: .top, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint(item: commentButton, attribute: .leading, relatedBy: .equal, toItem: likeButton, attribute: .trailing, multiplier: 1.0, constant: -25).isActive = true
    NSLayoutConstraint(item: commentButton, attribute: .width, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    
  }
  func shareButtonConstraints(){
    addSubview(shareButton)
    shareButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: shareButton, attribute: .top, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint(item: shareButton, attribute: .trailing, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    NSLayoutConstraint(item: shareButton, attribute: .height, relatedBy: .equal, toItem: shareButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
}
