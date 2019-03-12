//
//  SignUpFormViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpFormViewController: UIViewController {

  private let signUpForm = SignUpViewForm()
  private var userSession: UserSession!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.addSubview(signUpForm)
  
      setTheDelegates()
      signUpButtonAction()
      signUpForm.cancelButton.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
    
    }
  private func setTheDelegates(){
    signUpForm.passwordTextField.delegate = self
    signUpForm.emailTextField.delegate = self
    userSession = AppDelegate.theUser
  }

  @objc private func dismissPage(){
    self.dismiss(animated: true, completion: nil)
  }
  
 private func signUpButtonAction(){
    signUpForm.signUpButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
  }
 @objc private func saveUser() {
  guard let email = signUpForm.emailTextField.text,
    let password = signUpForm.passwordTextField.text,
    !email.isEmpty,!password.isEmpty else {
      showAlert(title: "All fields Required", message: "You must enter your email and password")
      return
  }
  userSession.createUser(email: email, password: password)
  
  let createProfile = SetProfileViewController()
  self.present(createProfile, animated: true, completion: nil)
  }
 
  
}
extension SignUpFormViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
extension SignUpViewController:UserSessionAccountCreationDelegate{
  func didReceiveError(_ userSession: UserSession, error: Error) {
    showAlert(title: "Error!", message: "There was an error logging in: \(error.localizedDescription)")
  }
  
  func didCreateAccount(_ userSession: UserSession, user: User) {
    showAlert(title: "Alert Created", message: "Your account was sucessfully created")
  }
  
  
}
