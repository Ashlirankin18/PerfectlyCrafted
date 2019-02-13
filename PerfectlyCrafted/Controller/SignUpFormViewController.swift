//
//  SignUpFormViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SignUpFormViewController: UIViewController {

  let signUpForm = SignUpViewForm()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.addSubview(signUpForm)
      view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
      signUpForm.passwordTextField.delegate = self
      signUpForm.userNameTextField.delegate = self
      signUpForm.emailTextField.delegate = self
      signUpForm.confirmEmailTextField.delegate = self
      signUpForm.cancelButton.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
      signUpButtonAction()
      
    }
  
  func setUpAlertController(title:String,message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }
  @objc private func dismissPage(){
    self.dismiss(animated: true, completion: nil)
  }
  
 private func signUpButtonAction(){
    signUpForm.signUpButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
  }
 @objc private func saveUser() {
  guard !(signUpForm.userNameTextField.text?.isEmpty)!,!(signUpForm.passwordTextField.text?.isEmpty)!,!(signUpForm.emailTextField.text?.isEmpty)!,!(signUpForm.confirmEmailTextField.text?.isEmpty)! else{
    setUpAlertController(title: "TextField Blank", message: "All Fields are required")
    return
  }
  guard !UserPersistanceHelper.getUsersInfo().contains(where: { (user) -> Bool in
    user.email == signUpForm.emailTextField.text
  })else{
    setUpAlertController(title: "Email exist", message: "The email you entered has been used. If you would like to sign in click the login button")
    return
  }
  
  let userName = signUpForm.userNameTextField.text ?? "No text entered"
  print(userName)
  let password = signUpForm.passwordTextField.text ?? "No text entered"
  print(password)
  let email = signUpForm.emailTextField.text ?? "No text entered"
  print(email)
  let confirmedEmail = signUpForm.confirmEmailTextField.text ?? "No text entered"
  var emailCheck = checkEmails(email: email, confirmEmail: confirmedEmail)
 
  if emailCheck == false {
   emailCheck = checkEmails(email: email, confirmEmail: confirmedEmail)
  }else {
    
 let user = User.init(userName: userName, password: password, email: email, profileImage: nil, fullName: nil, dateOfBirth: nil)
    UserPersistanceHelper.addToDocumentsDirectory(user: user)
    let tabBarController = PerfectlyCraftedTabBarViewController()
    tabBarController.user = user
    present(tabBarController, animated: true, completion: nil)
  }
  }
  private func checkEmails(email:String,confirmEmail:String) -> Bool{
    if email != confirmEmail {
      setUpAlertController(title: "Emails are not identical", message: "Email Addresses must match reenter email")
      signUpForm.emailTextField.clearsOnBeginEditing = true
      signUpForm.confirmEmailTextField.clearsOnBeginEditing = true
      return false
    }else{
      return true
    }
  }
  
}
extension SignUpFormViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
