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

  let hairCareOptions = ["Hair Products"]
  let hairOptionImages = [#imageLiteral(resourceName: "hairregimein.jpg")]
  
  
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
    view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    setDelegates()
    let signOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonPressed))
    self.navigationItem.rightBarButtonItem = signOutButton
  
    }
  private func setDelegates(){
    userSession = AppDelegate.theUser
    profileView.profileCollectionView.delegate = self
    profileView.profileCollectionView.dataSource = self
      userSession.userSessionSignOutDelegate = self
    
  }
  
  @objc func signOutButtonPressed(){
  userSession.signOut()
    
  }
  private func getProfileImage(button:UIButton,imageUrl:String){
    if let image = ImageCache.shared.fetchImageFromCache(urlString: imageUrl){
      DispatchQueue.main.async {
        button.setImage(image, for: .normal)
      }
    }else{
      ImageCache.shared.fetchImageFromNetwork(urlString: imageUrl) { (error, image) in
        if let error = error{
          print(error.errorMessage())
        }
        else if let image = image {
          DispatchQueue.main.async {
            button.setImage(image, for: .normal)
          }
        }
      }
    }
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setUserProfile()
  }
  
  private func setUserProfile(){
    if let user = userSession.getCurrentUser(){
    
      let documentRef = DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document(user.uid)
      documentRef.getDocument { (document, error) in
        if let error = error{
          print(error.localizedDescription)
        }
        else if let document = document, document.exists {
          guard let userData = document.data() else {return}
          let profileUser = UserModel.init(dict: userData)
          self.profileView.hairType.text = "Hair Type: \(profileUser.hairType ?? "")"
          self.profileView.userName.text = profileUser.userName
          self.profileView.aboutMeTextView.text = profileUser.aboutMe
         
          self.getProfileImage(button:  self.profileView.profileImage, imageUrl: profileUser.profileImageLink!)
        }
      }
    }else{
      print("no user logged in")
    }
  }
}
extension ProfileViewController:UICollectionViewDelegateFlowLayout{
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 250, height: 500)
  }
}
extension ProfileViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
      return hairCareOptions.count
    
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileView.profileCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {fatalError("No cell could be dequeue")}
    cell.collectionLabel.text = hairCareOptions[indexPath.row]
    cell.cellBackgroundImage.image = hairOptionImages[indexPath.row]
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      guard let productViewController = UIStoryboard(name: "ProfileOptions", bundle: nil).instantiateViewController(withIdentifier: "HairProductsTableViewController") as? HairProductsTableViewController else {
        print("No HairProductsTableViewController found")
        return
        
      }
      
      self.present(productViewController, animated: true, completion: nil)
    }
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

  

