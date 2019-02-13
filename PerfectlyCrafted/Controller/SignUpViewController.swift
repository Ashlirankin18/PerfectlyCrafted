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
    self.view.backgroundColor = #colorLiteral(red: 0.6722700215, green: 1, blue: 0.6019102933, alpha: 1)
    signUpView.signUpButton.addTarget(self, action: #selector(presentMainPage), for: .touchUpInside)
    signUpView.loginButton.addTarget(self, action: #selector(presentLoginPage), for: .touchUpInside)
    
  }
  
  @objc private func presentMainPage(){
  self.present(SignUpFormViewController(), animated: true, completion: nil)
    
  }
  @objc private func presentLoginPage(){
    self.present(PerfectlyCraftedTabBarViewController(), animated: true, completion: nil)
  }
}
