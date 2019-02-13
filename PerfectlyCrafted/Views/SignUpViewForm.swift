//
//  SignUpViewForm.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SignUpViewForm: UIView {
  lazy var titleLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textColor = .white
    label.numberOfLines = 0
    label.text = "Welcome to Perfectly Crafted"
    label.textAlignment = .center
    label.font = UIFont(name: "Times", size: 30)
    return label
  }()
  
  lazy var userNameTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    return textField
  }()
  lazy var usernameLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textColor = .white
    label.numberOfLines = 0
    label.text = "Username"
    label.textAlignment = .center
    return label
  }()
  lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = true
    return textField
  }()
  lazy var passwordLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textColor = .white
    label.text = "Password"
    label.textAlignment = .center
    return label
  }()
 
  lazy var emailTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    
    return textField
  }()
  
  lazy var emailLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "Email"
    label.textAlignment = .center
    label.textColor = .white
    
    return label
  }()
  
  lazy var confirmEmailTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    textField.textAlignment = .left
    return textField
  }()
  lazy var confirmEmailLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textAlignment = .center
    label.text = "Confirm Email"
    label.textColor = .white
    label.numberOfLines = 0
    return label
  }()
  lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "bobby-rodriguezz-617687-unsplash-3")
    return imageView
  }()
  lazy var signUpButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  lazy var cancelButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("Cancel", for: .normal)
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame:UIScreen.main.bounds)
    commonInit()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    setUpView()
    
  }
  
}
extension SignUpViewForm{
  
  func setUpView(){
    setUpImageViewConstraints()
    setUpTitleLabel()
    setUpCancelButton()
    setUpUsernameTextfield()
    setUpPasswordTextField()
    setUpEmailTextfield()
    setUpConfirmTextField()
    usernameLabelConstraint()
    setSetUpPasswordLabel()
    setUpEmailLabel()
    setUpConfirmEmail()
    setUpSignUpButton()
  }
  func setUpUsernameTextfield(){
    addSubview(userNameTextField)
    userNameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.init(item: userNameTextField, attribute: .top, relatedBy: .lessThanOrEqual, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 150).isActive = true
    NSLayoutConstraint.init(item: userNameTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: userNameTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
  }
  func setUpPasswordTextField(){
    addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: userNameTextField, attribute: .bottom, multiplier: 1.0, constant: 40.0).isActive = true
  NSLayoutConstraint.init(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
  NSLayoutConstraint.init(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    
  }
  func setUpEmailTextfield(){
    addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    NSLayoutConstraint.init(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    
  }
  func setUpConfirmTextField(){
    addSubview(confirmEmailTextField)
  confirmEmailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: confirmEmailTextField, attribute: .top, relatedBy: .equal, toItem:  emailTextField, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    
    NSLayoutConstraint.init(item: confirmEmailTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: confirmEmailTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
  }
  
  private func setUpImageViewConstraints(){
    addSubview(backgroundImageView)
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    
  }
  func setUpTitleLabel(){
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    
    NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  
  func usernameLabelConstraint(){
     addSubview(usernameLabel)
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: usernameLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 150).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .trailing, relatedBy: .equal, toItem: userNameTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .height, relatedBy: .equal, toItem: userNameTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setSetUpPasswordLabel(){
     addSubview(passwordLabel)
passwordLabel.translatesAutoresizingMaskIntoConstraints = false
   
    NSLayoutConstraint.init(item: passwordLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: usernameLabel, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .trailing, relatedBy: .equal, toItem: passwordTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpEmailLabel(){
    addSubview(emailLabel)
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: emailLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: passwordLabel, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
   
    NSLayoutConstraint.init(item: emailLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: emailLabel, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    
    NSLayoutConstraint.init(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: emailTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpConfirmEmail(){
    addSubview(confirmEmailLabel)
    confirmEmailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: confirmEmailLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: emailLabel, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    
    NSLayoutConstraint.init(item: confirmEmailLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: confirmEmailLabel, attribute: .trailing, relatedBy: .equal, toItem: confirmEmailTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    
    NSLayoutConstraint.init(item: confirmEmailLabel, attribute: .height, relatedBy: .equal, toItem: confirmEmailTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpSignUpButton(){
    addSubview(signUpButton)
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: signUpButton, attribute: .top, relatedBy: .equal, toItem: confirmEmailLabel, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: signUpButton, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 150).isActive = true
  }
  func setUpCancelButton(){
    addSubview(cancelButton)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
  }
}
