//
//  LoginViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  let loginView = LoginView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.addSubview(loginView)
      loginView.userNameTextField.delegate = self
      loginView.passwordTextField.delegate = self
    
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      loginView.loginButton.addTarget(self, action: #selector(presentMainPage), for: .touchUpInside)
      loginView.cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
  func setUpAlertController(title:String,message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }
  @objc private func dismissController(){
    self.dismiss(animated: true, completion: nil)
  }
  @objc private func presentMainPage(){
    guard !(loginView.userNameTextField.text?.isEmpty)!,!(loginView.passwordTextField.text?.isEmpty)! else {
      setUpAlertController(title: "All Fields Required", message: "You must enter username and password")
      return
    }
    if UserPersistanceHelper.getUsersInfo().isEmpty {
      setUpAlertController(title: "SignUp Required", message: "You must create a an account")
    }else {
      let enteredUsername = loginView.userNameTextField.text ?? "No text Entered"
      let enteredPassword = loginView.passwordTextField.text ?? "No text entered"
      if let currentUser = UserSession.currentUser(userName: enteredUsername, password: enteredPassword){
        let tabBarController = PerfectlyCraftedTabBarViewController()
        tabBarController.user = currentUser
        self.present(tabBarController, animated: true, completion: nil)
      } else {
        setUpAlertController(title: "Incorrect", message: "Username or Paswword Incorrect ")
        loginView.userNameTextField.clearsOnBeginEditing = true
        loginView.passwordTextField.clearsOnBeginEditing = true
      }
      
    }
   
  }
  

}
extension LoginViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}
