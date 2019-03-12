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
  
  lazy var profileImage:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "gift-habeshaw-1217521-unsplash-1"), for: .normal)
    button.clipsToBounds = true
    return button
  }()
  lazy var userName:UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Helvetica", size:  14)
    label.numberOfLines = 0
    return label
  }()
  lazy var locationLabel:UILabel = {
    let label = UILabel()
      label.font = UIFont(name: "Helvetica", size: 24)
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
    button.setImage(#imageLiteral(resourceName: "icons8-bookmark-25"), for: .normal)
    return button
  }()
  lazy var captionLabel: UILabel = {
    let label = UILabel()
    label.text = "Caption"
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  lazy var dateLabel:UILabel = {
    let label = UILabel()
    label.text = "Date"
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont(name: "Helvetica", size:  11)
    label.textColor = UIColor.lightGray
    label.backgroundColor = .white
    return label
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  override func layoutSubviews() {
  profileImage.layer.cornerRadius = profileImage.bounds.width/2
  }
  required init?(coder aDecoder: NSCoder) {
  super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    setUpViews()
  }
}
extension FeedsCollectionViewCell{
  func setUpViews(){
    setUpUserDetailsView()
    setUpPostImageConstraints()
    setUpCommentsandLikesView()
    
    
  }
  
  func setUpUserDetailsView(){
    addSubview(userDetailsView)
userDetailsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: userDetailsView, attribute: .top, relatedBy:.equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.2, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .trailing, relatedBy: .equal, toItem:safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: userDetailsView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.10, constant: 0).isActive = true
    setUpProfileImage()
    setUpUsernameLabel()
    setUpLocationLabel()
    shareButtonConstraints()
    
  }
  func setUpProfileImage(){
    addSubview(profileImage)
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: profileImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.0, constant: 4).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .width, relatedBy: .equal, toItem: profileImage, attribute: .width, multiplier: 0.1, constant: 40).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 0.1, constant: 40).isActive = true
    NSLayoutConstraint.init(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: userDetailsView, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
  }
  func setUpUsernameLabel(){
    userDetailsView.addSubview(userName)
userName.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: userName, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint.init(item: userName, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: userName, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 0.7, constant: 0).isActive = true
  }
  func setUpLocationLabel(){
   userDetailsView.addSubview(locationLabel)
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: locationLabel, attribute: .top, relatedBy: .equal, toItem: userName, attribute: .top, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: locationLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: locationLabel, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 0.7, constant: 0).isActive = true
  }
  func setUpPostImageConstraints(){
   userDetailsView.addSubview(postImage)
    postImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: postImage, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .leading, relatedBy: .equal, toItem: userDetailsView, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: postImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0.70, constant: 0).isActive = true
  }
  func setUpCommentsandLikesView(){
    addSubview(commentsAndLikeView)
commentsAndLikeView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .top, relatedBy:.equal, toItem: postImage, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .trailing, relatedBy: .equal, toItem:safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: commentsAndLikeView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.29, constant: 0).isActive = true
    setUpCaptionLabel()
    setDateLabel()
}
  func setUpLikeButtonConstraints(){
  commentsAndLikeView.addSubview(likeButton)
likeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: likeButton, attribute: .top, relatedBy: .equal, toItem: captionLabel, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
   likeButton.leadingAnchor.constraint(equalTo: commentsAndLikeView.leadingAnchor, constant: 10).isActive = true
    
  }
  func setUpCommentButtonConstraints(){
   commentsAndLikeView.addSubview(commentButton)
commentButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: commentButton, attribute: .top, relatedBy: .equal, toItem: captionLabel, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint(item: commentButton, attribute: .leading, relatedBy: .equal, toItem: likeButton, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    NSLayoutConstraint(item: commentButton, attribute: .width, relatedBy: .equal, toItem: commentsAndLikeView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    
  }
  func shareButtonConstraints(){
   userDetailsView.addSubview(shareButton)
shareButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: shareButton, attribute: .top, relatedBy: .equal, toItem: userDetailsView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: shareButton, attribute: .trailing, relatedBy: .equal, toItem: userDetailsView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    NSLayoutConstraint(item: shareButton, attribute: .height, relatedBy: .equal, toItem: shareButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpCaptionLabel(){
   commentsAndLikeView.addSubview(captionLabel)
captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.topAnchor.constraint(equalTo: commentsAndLikeView.topAnchor, constant: 10).isActive = true
    captionLabel.leadingAnchor.constraint(equalTo: commentsAndLikeView.leadingAnchor, constant: 10).isActive = true
    captionLabel.trailingAnchor.constraint(equalTo: commentsAndLikeView.trailingAnchor, constant: -10).isActive = true
    
  }
  func setDateLabel(){
    commentsAndLikeView.addSubview(dateLabel)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 70).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: commentsAndLikeView.leadingAnchor, constant: 10).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: commentsAndLikeView.trailingAnchor, constant: -10).isActive = true
    dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
  }
  
}
