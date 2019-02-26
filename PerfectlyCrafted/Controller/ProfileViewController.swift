//
//  ProfileViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

  var profileView = ProfileView()
  var userSession: UserSession!
  
  init(view:ProfileView) {
    super.init(nibName: nil, bundle: nil)
    
    self.profileView = view
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    view.addSubview(profileView)
      profileView.profileCollectionView.delegate = self
    profileView.profileCollectionView.dataSource = self
       view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    let signOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonPressed))
    self.navigationItem.rightBarButtonItem = signOutButton
    userSession = (UIApplication.shared.delegate as! AppDelegate).userSession
    userSession.userSessionSignOutDelegate = self
    }
    
  @objc func signOutButtonPressed(){
  userSession.signOut()
  }
    
}
extension ProfileViewController:UICollectionViewDelegateFlowLayout{
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 250, height: 500)
  }
}
extension ProfileViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileView.profileCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {fatalError("No cell could be dequeue")}
    return cell
  }
  
}
extension ProfileViewController: UserSessionSignOutDelegate{
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
