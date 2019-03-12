//
//  ProfileViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Toucan
class ProfileViewController: UIViewController {

 private var profileView = ProfileView()
 private var userSession: UserSession!
 private var tapGesture: UITapGestureRecognizer!
 private var imagePickerController: UIImagePickerController!
 private var storageManager: StorageManager!
  private var appUser: UserModel!
  
  private var myPosts = [FeedModel](){
    didSet{
      self.profileView.profileCollectionView.reloadData()
      self.myPosts.sort{$0.datePosted < $1.datePosted}
    }
  }
  
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
    storageManager = (UIApplication.shared.delegate as? AppDelegate)?.storageManager
     storageManager.delegate = self
    setUpButtons()
    setUpImagePicker()
  
    getMyPost()
    }
  private func setUpButtons(){
    let signOutButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-settings-25.png"), style: .plain, target: self, action: #selector(settingsButtonPressed))
    self.navigationItem.rightBarButtonItem = signOutButton
    profileView.profileImage.addTarget(self, action: #selector(profileImagePressed), for: .touchUpInside)
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
  @objc private func settingsButtonPressed(){
    guard let settingsViewController = UIStoryboard(name: "ProfileOptions", bundle: nil).instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {return}
 
    self.present(settingsViewController, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setUserProfile()
  }
  
  private func setUserProfile(){
    if let user = userSession.getCurrentUser(){
    
      _ = DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document(user.uid).addSnapshotListener { [weak self] (snapshot, error) in
        if let error = error{
          print(error.localizedDescription)
        }
        else if let snapshot = snapshot{
          guard let userData = snapshot.data() else {return}
          let profileUser = UserModel.init(dict: userData)
          self?.setUpUi(user: profileUser)
          self?.appUser = profileUser
        }
      }
      }else{
      print("no user logged in")
    }
  }
  
  private func setUpUi(user:UserModel){
    self.profileView.hairType.text = "\(user.hairType ?? "")"
    self.profileView.userName.text = user.userName
    self.profileView.aboutMeTextView.text = user.aboutMe
    
    self.profileView.profileImage.kf.setImage(with: URL(string: user.profileImageLink!), for: .normal,placeholder:#imageLiteral(resourceName: "placeholder.png"))
  }
private func getMyPost(){
    guard let user = userSession.getCurrentUser() else {return}
    DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.feed).addSnapshotListener { [weak self ](snapshot, error) in
      if let error = error{
        print(error.localizedDescription)
      }
      else if let snapshot = snapshot{
        snapshot.query.whereField("userId", isEqualTo: user.uid).getDocuments(completion: { [weak self] (snapshot, error) in
          self?.myPosts.removeAll()
          snapshot?.documents.forEach{
            let results = $0.data()
            let myFeed = FeedModel(dict: results)
            self?.myPosts.append(myFeed)
          }
        })
      }
    }
  }
}
extension ProfileViewController:UICollectionViewDelegateFlowLayout{
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 400, height: 600)
  }
}
extension ProfileViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
      return myPosts.count
    
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileView.profileCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCell", for: indexPath) as? FeedsCollectionViewCell else {fatalError("No cell could be dequeue")}
    let feed = myPosts[indexPath.row]
    cell.userName.text = feed.userName
    cell.captionLabel.text = feed.caption
    cell.dateLabel.text = feed.datePosted
    cell.postImage.kf.setImage(with: URL(string: feed.imageURL),placeholder:#imageLiteral(resourceName: "placeholder.png") )
    if let imageUrl = appUser.profileImageLink{
      cell.profileImage.kf.setImage(with: URL(string: imageUrl), for: .normal,placeholder:#imageLiteral(resourceName: "placeholder.png"))
    }
   
    cell.postImage.kf.indicatorType = .activity
    return cell
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

  let resizedImages = Toucan(image: image).resize(CGSize.init(width: 500, height: 500)).maskWithEllipse().image
        profileView.profileImage.setImage(resizedImages, for: .normal)
    if let imageData = resizedImages?.jpegData(compressionQuality: 0.5){
      storageManager.postImage(withData: imageData)
    }
    
    dismiss(animated: true, completion: nil)
  }
  
}
extension ProfileViewController: StorageManagerDelegate{
  func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
    DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document((self.userSession.getCurrentUser()?.uid)!).updateData(["imageURL":imageURL.absoluteString]) { (error) in
      if let error = error{
        print(error.localizedDescription)
      }
    }
  }
  
  
}



