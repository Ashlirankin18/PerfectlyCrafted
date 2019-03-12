//
//  SetUpProfileView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/26/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SetUpProfileView: UIView {

 lazy var backgroundImage:UIImageView = {
    let imageView = UIImageView()
  imageView.image = #imageLiteral(resourceName: "pexels-photo-1181685")
    return imageView
  }()
  lazy var profileContainerView:UIView = {
    let view = UIView()
    view.isOpaque = false
    view.backgroundColor = #colorLiteral(red: 0.7359851126, green: 0.7359851126, blue: 0.7359851126, alpha: 0.8459171661)
    view.layer.cornerRadius = 10
    return view
  }()

  lazy var profileImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "placeholder.png")
    return imageView
  }()

  lazy var userNameTextField:UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.layer.cornerRadius = 5
    return textField
  }()

  lazy var userNameLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    label.text = "Create UserName"
    return label
  }()

  // I want to create a dropdown menu for the hair type

  lazy var hairTypeMenu:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    label.text = "Hair Type"
    return label
  }()
  
  lazy var hairTypeInput:UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.layer.cornerRadius = 5
    return textField
  }()
  
  lazy var aboutMeLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    label.text = "About Me"
    return label
  }()
  
  lazy var aboutMeTextView:UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.text = "About me"
    textView.layer.cornerRadius = 7
    
    return textView
  }()

  lazy var setUpButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("Create Profile", for: .normal)
    button.layer.cornerRadius = 10
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 2
    return button
  }()

  override func layoutSubviews() {
    profileImage.layer.cornerRadius = profileImage.bounds.width/2
    profileImage.layer.masksToBounds = true
  }
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
   backgroundColor = .clear
    setUpViews()
  }
  
}
extension SetUpProfileView{
  func setUpViews(){
    setUpBackgroundImage()
    setupContainerView()
  }
  func setUpBackgroundImage(){
    addSubview(backgroundImage)
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
     backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
     backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  func setupContainerView(){
    addSubview(profileContainerView)
    profileContainerView.translatesAutoresizingMaskIntoConstraints = false
    profileContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
    profileContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    profileContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.4).isActive = true
    profileContainerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    setUpProfileImage()
    setUpUserNameLabel()
    setUpUserNameTextField()
    setUpHairTypeLabel()
    setUpHairType()
    setUpAboutMeLabel()
    setupAboutMeTextView()
    setUpCreateButton()
  }
  func setUpProfileImage(){
    profileContainerView.addSubview(profileImage)
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    profileImage.topAnchor.constraint(equalToSystemSpacingBelow: profileContainerView.topAnchor, multiplier: 1.4).isActive = true
    profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
     profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
    profileImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
  }
  
  func setUpUserNameLabel(){
    profileContainerView.addSubview(userNameLabel)
    userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    userNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
    userNameLabel.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 10).isActive = true
    
  }
  func setUpUserNameTextField(){
    profileContainerView.addSubview(userNameTextField)
    userNameTextField.translatesAutoresizingMaskIntoConstraints = false
    userNameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
    userNameTextField.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 20).isActive = true
    userNameTextField.widthAnchor.constraint(equalToConstant: 180).isActive = true
    
  }
  func setUpHairTypeLabel(){
    profileContainerView.addSubview(hairTypeMenu)
    hairTypeMenu.translatesAutoresizingMaskIntoConstraints = false
    hairTypeMenu.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30).isActive = true
    hairTypeMenu.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 10).isActive = true
  }
  func setUpHairType(){
    profileContainerView.addSubview(hairTypeInput)
   hairTypeInput.translatesAutoresizingMaskIntoConstraints = false
    hairTypeInput.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 30).isActive = true
   hairTypeInput.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 20).isActive = true
    hairTypeInput.widthAnchor.constraint(equalToConstant: 180).isActive = true
  }
  func setUpAboutMeLabel(){
    profileContainerView.addSubview(aboutMeLabel)
    aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
    aboutMeLabel.topAnchor.constraint(equalTo: hairTypeMenu.bottomAnchor, constant: 30).isActive = true
    aboutMeLabel.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 140).isActive = true
   
  }
  func setupAboutMeTextView(){
    profileContainerView.addSubview(aboutMeTextView)
    aboutMeTextView.translatesAutoresizingMaskIntoConstraints = false
    aboutMeTextView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 30).isActive = true
    aboutMeTextView.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 20).isActive = true
    aboutMeTextView.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor, constant: -20).isActive = true
    aboutMeTextView.heightAnchor.constraint(equalTo: profileContainerView.heightAnchor, multiplier: 0.2).isActive = true
  }
  func setUpCreateButton(){
    profileContainerView.addSubview(setUpButton)
    setUpButton.translatesAutoresizingMaskIntoConstraints = false
    setUpButton.topAnchor.constraint(equalTo: aboutMeTextView.bottomAnchor, constant: 30).isActive = true
    setUpButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    setUpButton.bottomAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: -20).isActive = true
    setUpButton.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 120).isActive = true
  }
  
}

