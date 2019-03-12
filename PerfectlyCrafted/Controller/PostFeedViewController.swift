//
//  PostFeedViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PostFeedViewController: UIViewController {

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var postCaption: UITextView!
  
  @IBOutlet weak var post: UIButton!
  private var userSession: UserSession!
  public var productToPost: ProductModel!{
    didSet{
      self.getProductInfo(product: productToPost)
    }
  }
  
  @IBOutlet weak var containerView: UIView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    containerView.layer.masksToBounds = true
    containerView.layer.cornerRadius = 10
    setUpUi()
    userSession = AppDelegate.theUser
    postCaption.delegate = self
    textViewSetUp()
    
    
    }
  @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  @IBAction func postButtonPressed(_ sender: UIButton) {
    guard let theUser = userSession.getCurrentUser(),
      let product = productToPost,
      let caption = self.postCaption.text else{return}
      let date = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      let dateString = dateFormatter.string(from: date)
      let feed = FeedModel.init(feedId: "", userId: theUser.uid, userImageLink: (theUser.photoURL?.absoluteString)!, productId: product.productId, imageURL: product.productImage, caption: caption, userName: theUser.displayName!, datePosted: dateString)
    DataBaseManager.postFeedTo(feed: feed, user: theUser)
    dismiss(animated: true)
  }
  
  private func textViewSetUp(){
    postCaption.text = "Share your experience here"
    postCaption.textColor = .gray
    postCaption.enablesReturnKeyAutomatically = true
    
  }
  private func setUpUi(){
    guard let product = productToPost else {return}
    getImage(ImageView: self.productImage, imageURLString: product.productImage)
    self.productName.text = product.productName
    
  }
  private func getProductInfo(product:ProductModel){
DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.products).whereField("productName", isEqualTo: product.productName).getDocuments { [weak self] (snapshot, error) in
      if let error = error{
        print(error)
      }
      else if let snapshot = snapshot{
        if let result = snapshot.documents.first?.data(){
          let newProduct = ProductModel.init(dict: result)
          self?.productToPost = newProduct
        }
      }
    }
  }
  
  

  
}
extension PostFeedViewController: HairProductsTableViewControllerDelegate{
  func sendSelectedProduct(_ controller: HairProductsTableViewController, selectedProduct: ProductModel) {
    
    controller.delegate = self
    self.productToPost = selectedProduct
    
  }
  
  
}
extension PostFeedViewController:UITextViewDelegate{
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
