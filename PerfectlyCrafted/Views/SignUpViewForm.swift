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

  lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = true
    return textField
  }()
  lazy var emailLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.textColor = .white
    label.text = "Email"
    label.textAlignment = .center
    return label
  }()
 
  lazy var emailTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    
    return textField
  }()
  
  lazy var passwordLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "Password"
    label.textAlignment = .center
    label.textColor = .white
    
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
    setUpEmailTextField()
    setUpPasswordTextfield()
    setSetUpEmailLabel()
    setUpPasswordLabel()
    setUpSignUpButton()
  }
  
  func setUpEmailTextField(){
    addSubview(emailTextField)
emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: emailTextField, attribute: .centerY, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: -40).isActive = true
  NSLayoutConstraint.init(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
  NSLayoutConstraint.init(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    
  }
  func setUpPasswordTextfield(){
    addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
    NSLayoutConstraint.init(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 140).isActive = true
    NSLayoutConstraint.init(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
    
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
  

  func setSetUpEmailLabel(){
     addSubview(emailLabel)
emailLabel.translatesAutoresizingMaskIntoConstraints = false
   
    NSLayoutConstraint.init(item: emailLabel, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: -40).isActive = true
    NSLayoutConstraint.init(item: emailLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: emailLabel, attribute: .trailing, relatedBy: .equal, toItem: passwordTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    NSLayoutConstraint.init(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpPasswordLabel(){
    addSubview(passwordLabel)
    passwordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: passwordLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: emailLabel, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
   
    NSLayoutConstraint.init(item: passwordLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
    NSLayoutConstraint.init(item: passwordLabel, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .leading, multiplier: 1.0, constant: -30).isActive = true
    
    NSLayoutConstraint.init(item: passwordLabel, attribute: .height, relatedBy: .equal, toItem: emailTextField, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
    func setUpSignUpButton(){
    addSubview(signUpButton)
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: signUpButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
    NSLayoutConstraint.init(item: signUpButton, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 150).isActive = true
      
  }
  func setUpCancelButton(){
    addSubview(cancelButton)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
  }
}
