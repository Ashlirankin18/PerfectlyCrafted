//
//  SettingsTableViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsTableViewController: UITableViewController {
   @IBOutlet var editProfileView: UIView!
  private var initialView: UIView?
  var userSession: UserSession!
  var firebaseUser: UserModel!
  var updateButton: UIBarButtonItem!
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
      userSession = AppDelegate.theUser
      userSession.userSessionSignOutDelegate = self
     
      if let myView = initialView {
        view = myView
      }
      getUserFromFirebase()
    }
  
  @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  @IBAction func signOutPressed(_ sender: UIButton) {
    userSession.signOut()
  }
  
  @IBAction func EditProfilePressed(_ sender: UIButton) {
    self.initialView = view
    updateButton = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(updateButtonPressed))
    self.navigationItem.rightBarButtonItem = updateButton
    setUserData()
    self.view = editProfileView
    
  }

  @objc private func updateButtonPressed(){
    guard let currentView = editProfileView as? EditProfileView else {return}
    let url = URL(fileURLWithPath: firebaseUser.profileImageLink!)
    userSession.updateExistingUser(imageURL: url, userName: currentView.userName.text , hairType: currentView.userHairType.text, bio: currentView.userBio.text)
    view = initialView
    updateButton.isEnabled = false
    
  }

  

  private func getUserFromFirebase() {
    guard let user = userSession.getCurrentUser()else{return}
DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document(user.uid).getDocument { (snapshot, error) in
      if let error = error {
        print(error)
      }
      else if let snapshot = snapshot{
        if let userData = snapshot.data(){
          let user = UserModel.init(dict: userData)
          self.firebaseUser = user
        }
      }
    }
  }
  
  private func setUserData(){
    guard let newView = editProfileView as? EditProfileView,
    let user = userSession.getCurrentUser(),
    let firebaseUser = firebaseUser else {return}
    getImage(ImageView: newView.UserImage, imageURLString: (user.photoURL?.absoluteString)!)
    newView.userName.delegate = self
    newView.userHairType.delegate = self
    newView.userName.text = firebaseUser.userName
    newView.userHairType.text = firebaseUser.hairType
    newView.userBio.text = firebaseUser.aboutMe
  }
}

extension SettingsTableViewController: UserSessionSignOutDelegate{
  func didReceiveSignOutError(_ userSession: UserSession, error: Error) {
    showAlert(title: "Error", message: "There was an error signing out: \(error.localizedDescription)")
    
  }
  
  func didSignOutUser(_userSession: UserSession) {
    showAlert(title: "Sign Out Sucessful", message: "You were sucessfully signed out")
    let window = (UIApplication.shared.delegate as! AppDelegate).window
    let loginViewController = SignUpViewController()
    window?.rootViewController = loginViewController
  }
}
extension SettingsTableViewController: UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
