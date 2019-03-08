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
  var tapGesture: UITapGestureRecognizer!
  var imagePickerController: UIImagePickerController!
  var storageManager: StorageManager!
  let hairCareOptions = ["Hair Products","My Posts"]
  let hairOptionImages = [#imageLiteral(resourceName: "hairregimein.jpg"),#imageLiteral(resourceName: "houcine-ncib-667560-unsplash-1")]
  
  
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
    let signOutButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-settings-25.png"), style: .plain, target: self, action: #selector(settingsButtonPressed))
    self.navigationItem.rightBarButtonItem = signOutButton
    storageManager = (UIApplication.shared.delegate as? AppDelegate)?.storageManager
    profileView.profileImage.addTarget(self, action: #selector(profileImagePressed), for: .touchUpInside)
    setUpImagePicker()
    storageManager.delegate = self
    }

  private func showImagePickerController(){
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
  @objc private func profileImagePressed(){
    let actionSheet = UIAlertController(title: "Options", message: "How would you like to update your profile image?", preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
      if !UIImagePickerController.isSourceTypeAvailable(.camera){
        alertAction.isEnabled = false
      }else{
        self.imagePickerController.sourceType = .camera
        self.showImagePickerController()
      }
    }
    let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (alertAction) in
      self.showImagePickerController()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    actionSheet.addAction(cameraAction)
    actionSheet.addAction(galleryAction)
    actionSheet.addAction(cancelAction)
    self.present(actionSheet, animated: true, completion: nil)
  }
  

  private func setDelegates(){
    userSession = AppDelegate.theUser
    profileView.profileCollectionView.delegate = self
    profileView.profileCollectionView.dataSource = self
    
  }
  private func setUpImagePicker(){
    imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    
  }
  @objc func settingsButtonPressed(){
    guard let settingsViewController = UIStoryboard(name: "ProfileOptions", bundle: nil).instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {return}
 
    self.present(settingsViewController, animated: true)
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
      productViewController.modalPresentationStyle = .currentContext
      productViewController.modalTransitionStyle = .coverVertical
      self.present(productViewController, animated: true, completion: nil)
    }
    if indexPath.row == 1{
     let myPostViewController = MyPostViewController()
      let navigationController = UINavigationController(rootViewController: myPostViewController)
      navigationController.modalTransitionStyle = .crossDissolve
      navigationController.modalPresentationStyle = .currentContext
      self.present(navigationController, animated: true, completion: nil)
    }
  }
}
extension ProfileViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      else{
        print("no original image could be found")
        return
    }
  
    profileView.profileImage.setImage(image, for: .normal)
    if let imageData = image.jpegData(compressionQuality: 0.5){
      storageManager.postImage(withData: imageData)
    }
    
    dismiss(animated: true, completion: nil)
  }
  
}
extension ProfileViewController: StorageManagerDelegate{
  func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
    userSession.updateExistingUser(imageURL: imageURL, userName: profileView.userName.text, hairType: profileView.hairType.text, bio: profileView.aboutMeTextView.text)
  }
  
  
}



