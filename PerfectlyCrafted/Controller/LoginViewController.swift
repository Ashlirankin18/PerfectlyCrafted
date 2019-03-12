//
//  LoginViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
  
  private let loginView = LoginView()
  private var userSession: UserSession!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.addSubview(loginView)
      setUpdelegates()
      setUpNavBarButtons()
    }
  private func setUpdelegates(){
    loginView.userNameEmail.delegate = self
    loginView.passwordTextField.delegate = self
    userSession = AppDelegate.theUser
    userSession.userSignInDelegate = self
    
  }
  private func setUpNavBarButtons(){
    loginView.loginButton.addTarget(self, action: #selector(presentMainPage), for: .touchUpInside)
    loginView.cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
  }
 @objc func presentMainPage(){
    guard let email = loginView.userNameEmail.text,
    let password = loginView.passwordTextField.text,
      !email.isEmpty, !password.isEmpty else {
       
        showAlert(title: "All fields required", message: "you must enter email and password")
        return
  }
  userSession.signInExistingUser(email: email, password: password)
  
  }
  

  @objc private func dismissController(){
    self.dismiss(animated: true, completion: nil)
  }

  

}
extension LoginViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}
extension LoginViewController:UserSessionSignInExistingUserDelegate {
  func didReceiveSignInError(_ userSession: UserSession, error: Error) {
    showAlert(title: "There was an error signing in", message: "\(error.localizedDescription)")
  }
  
  func didSignInUser(_ userSession: UserSession, user: User) {
    let tabBarController = PerfectlyCraftedTabBarViewController()
    tabBarController.selectedViewController = tabBarController.viewControllers![0]
    self.present(tabBarController, animated: true, completion: nil)
  }
  
  
}
