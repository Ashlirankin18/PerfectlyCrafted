//
//  SetProfileViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/26/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher
import Toucan

protocol SetProfileViewControllerDelegate: AnyObject {
  func profileCreated(_ controller: SetProfileViewController,userProfile:UserModel)
}
class SetProfileViewController: UIViewController {
  var imageURL: URL?
  var imagePickerController: UIImagePickerController!
  weak var delegate: SetProfileViewControllerDelegate?
  weak var userSession: UserSession!
  private var storageManager: StorageManager!
  let setUpProfileView = SetUpProfileView()
  var tapGesture: UITapGestureRecognizer!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(setUpProfileView)
       userSession = AppDelegate.theUser
      setUpButtonAction()
      setUpProfileView.userNameTextField.delegate = self
      setUpProfileView.aboutMeTextView.delegate = self
      textViewSetUp()
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
   
    setUpImagePickerController()
    storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
    storageManager.delegate = self
    
  }
  private func textViewSetUp(){
    setUpProfileView.aboutMeTextView.text = "Let your friends know how amazing you are"
    setUpProfileView.aboutMeTextView.textColor = .gray
    setUpProfileView.userNameTextField.placeholder = "Enter your username"
    setUpProfileView.hairTypeInput.placeholder = "Enter your hair type"
  }
  func showImagePickerController(){
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func setUpImagePickerController(){
      imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
  }
  func setUpButtonAction(){
    setUpProfileView.userNameTextField.delegate = self
    setUpProfileView.hairTypeInput.delegate = self
    setUpProfileView.setUpButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    setUpTapGesture(imageView: setUpProfileView.profileImage)
  }
  func setUpTapGesture(imageView:UIImageView){
    tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(profileImagePressed))
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(tapGesture)
    
  }
  @objc func profileImagePressed(){
    showImagePickerController()
  }

  @objc func createButtonPressed(){
    if let _ = userSession.getCurrentUser(),let imageURL = imageURL {
      guard let bio = setUpProfileView.aboutMeTextView.text,
        let userName = setUpProfileView.userNameTextField.text,
        let hairType = setUpProfileView.hairTypeInput.text else {return}
    userSession.updateExistingUser(imageURL: imageURL, userName: userName, hairType: hairType, bio: bio)
     
   let tabbarController = PerfectlyCraftedTabBarViewController()
    tabbarController.selectedViewController = tabbarController.viewControllers?[0]
    self.present(tabbarController, animated: true, completion: nil)
    
    }
  }
}
extension SetProfileViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
extension SetProfileViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      showAlert(title: "Error with image", message: "Try Again")
      return}
    setUpProfileView.profileImage.image = originalImage
    let resizedImage = Toucan(image: originalImage).resize(CGSize.init(width: 500, height: 500)).maskWithEllipse().image
    let imageData = resizedImage?.jpegData(compressionQuality: 0.5)
    storageManager.postImage(withData: imageData!)
    dismiss(animated: true, completion: nil)
  }
  
}

  
  
extension SetProfileViewController: StorageManagerDelegate {
  func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
    self.imageURL = imageURL
  }
  
  
}
extension SetProfileViewController:UITextViewDelegate{
  func textViewDidBeginEditing(_ textView: UITextView) {
    if !textView.text.isEmpty {
      textView.text = ""
      textView.textColor = .black
    }
  }
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n"{
      textView.resignFirstResponder()
      return false
    }
    return true
  }
}
