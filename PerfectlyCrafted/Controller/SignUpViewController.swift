//
//  SignUpViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController {
  
  let signUpView = SignUpView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(signUpView)
    setButtons()
  }
  
  private func setButtons(){
    signUpView.signUpButton.addTarget(self, action: #selector(presentMainPage), for: .touchUpInside)
    signUpView.loginButton.addTarget(self, action: #selector(presentLoginPage), for: .touchUpInside)
  }
  
  @objc private func presentMainPage(){
  self.present(SignUpFormViewController(), animated: true, completion: nil)
    
  }
  @objc private func presentLoginPage(){
    self.present(LoginViewController(), animated: true, completion: nil)
  }
}
