//
//  SignUpView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

protocol SignUpViewDelegate: AnyObject {
  func didSelectSignUpButton(_ signUpView: SignUpView)
}

class SignUpView: UIView {
  
  weak var delegate: SignUpViewDelegate?
  
  lazy var backgroundImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "davids-kokainis-639292-unsplash-1")
    return imageView
  }()
  lazy var titleLabel:UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.font = UIFont(name: "Times", size: 40.0)
    label.textColor = .white
    label.text = "Perfectly Crafted"
    label.textAlignment = .center
    return label
  }()
  lazy var signUpButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.titleLabel?.textColor = .white
    button.setTitle("Sign Up", for: .normal)
    button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    button.titleLabel?.font = UIFont(name: "Times", size: 24.0)
    return button
  }()
  lazy var loginButton:UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.titleLabel?.textColor = .white
    button.setTitle("Login", for: .normal)
    button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    button.titleLabel?.font = UIFont(name: "Times", size: 24.0)
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
  private func commonInit(){
    setUpViews()
  }
  
  @objc private func signUpButtonPressed() {
    delegate?.didSelectSignUpButton(self)
  }
  
}
extension SignUpView{
  private func setUpViews(){
    setUpImageViewConstraints()
    setUpTitleLabel()
    setUpsignUpButtonConstraints()
    setUpLoginButton()
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
    NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: backgroundImageView, attribute: .top, multiplier: 1.0, constant: 100).isActive = true
    NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: backgroundImageView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpsignUpButtonConstraints(){
    addSubview(signUpButton)
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: signUpButton, attribute: .centerX, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerX, multiplier: 1.0, constant: -20).isActive = true
    NSLayoutConstraint.init(item: signUpButton, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpLoginButton(){
    addSubview(loginButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: signUpButton, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerX, multiplier: 1.0, constant: -20).isActive = true
    NSLayoutConstraint.init(item: loginButton, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1.0, constant: 30).isActive = true
   
  }
}
