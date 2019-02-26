//
//  LoginView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
class LoginView: UIView {
  lazy var titleLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textColor = .white
    label.numberOfLines = 0
    label.text = "Welcome Back"
    label.textAlignment = .center
    label.font = UIFont(name: "Times", size: 30)
    return label
  }()
  lazy var backgroundImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "gift-habeshaw-1217521-unsplash-1")
    return imageView
  }()
  lazy var userNameEmail: UITextField = {
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
  lazy var loginButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("Login", for: .normal)
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
    super.init(frame: UIScreen.main.bounds)
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
extension LoginView{
  func setUpViews(){
    setUpBackgroundImageConstraint()
    setUpTitleLabel()
    setUpCancelButton()
    setUpUsernameTetfield()
    usernameLabelConstraint()
    setUpPasswordTextField()
    setSetUpPasswordLabel()
    setUpLoginButton()
  }
  func setUpTitleLabel(){
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 40).isActive = true
    NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    
    NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpBackgroundImageConstraint(){
    addSubview(backgroundImageView)
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
      NSLayoutConstraint.init(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpUsernameTetfield(){
    addSubview(userNameEmail)
    userNameEmail.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.init(item: userNameEmail, attribute: .top, relatedBy: .lessThanOrEqual, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 300).isActive = true
    NSLayoutConstraint.init(item: userNameEmail, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: userNameEmail, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
  }
  func setUpPasswordTextField(){
    addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: userNameEmail, attribute: .bottom, multiplier: 1.0, constant: 40.0).isActive = true
    NSLayoutConstraint.init(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    
  }
  func usernameLabelConstraint(){
    addSubview(usernameLabel)
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: usernameLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 300).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .trailing, relatedBy: .equal, toItem: userNameEmail, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: usernameLabel, attribute: .height, relatedBy: .equal, toItem: userNameEmail, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setSetUpPasswordLabel(){
    addSubview(passwordLabel)
    passwordLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.init(item: passwordLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: usernameLabel, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .trailing, relatedBy: .equal, toItem: passwordTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpLoginButton(){
    addSubview(loginButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 150).isActive = true
  }
  func setUpCancelButton(){
    addSubview(cancelButton)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
  }
}
