//
//  ShowProductViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ShowProductViewController: UIViewController {
  
  private var hairProduct: AllHairProducts!
  private var HairProductView: HairProductView!
  private var productImage = UIImage()
  private var userSession: UserSession!
  private var storageManager: StorageManager!
  
  init(hairProduct:AllHairProducts,view:HairProductView){
    super.init(nibName: nil, bundle: nil)
    self.hairProduct = hairProduct
    self.HairProductView = view
     let hairProductView = view
    self.view.addSubview(hairProductView)
    userSession = AppDelegate.theUser
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = .white
      HairProductView.productCollectionView.delegate = self
       HairProductView.productCollectionView.dataSource = self
     setUpButtons()
    }
  
  private func setUpButtons(){
    let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissPressed))
    navigationItem.leftBarButtonItem = backButton
    let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.title = "Category: \(hairProduct.results.category.capitalized)"
    
  }
  @objc private func dismissPressed(){
    dismiss(animated: true, completion: nil)
  }
  @objc private func addButtonPressed(){
    let theCurrentHairProduct = hairProduct.results
    guard let user = userSession.getCurrentUser(), let imageUrl =  theCurrentHairProduct.images.first?.absoluteString else {return}
    let category = theCurrentHairProduct.category
    DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.products).whereField("productName", isEqualTo: theCurrentHairProduct.name).getDocuments { (snapshot, error) in
      if let error = error{
        print(error.localizedDescription)
      }
      else if let snapshot = snapshot{
        if snapshot.documents.count == 0 {
          let product = ProductModel.init(productName: theCurrentHairProduct.name, productId: "", productDescription: theCurrentHairProduct.description, userId: user.uid, productImage: imageUrl, category: category, isCompleted: false)
          DataBaseManager.postProductToDatabase(product: product, user: user)
         
        }
      }
    }
    
    dismiss(animated: true)
  }
  
  func getProductImage(imageView:UIImageView,urlString:String){
    if let image = ImageCache.shared.fetchImageFromCache(urlString: urlString){
      imageView.image = image
      self.productImage = image
    }else{
      ImageCache.shared.fetchImageFromNetwork(urlString: urlString) { (error, image) in
        if let error = error {
          print(error.errorMessage())
        }
        if let image = image{
          DispatchQueue.main.async {
            imageView.image = image
            self.productImage = image
          }
        }
      }
    }
  }
  func getSelectedProduct( product:inout ProductModel) -> ProductModel? {
    guard let user = userSession.getCurrentUser() else{
      return nil
    }
    product.userId = user.uid
   return product
  }
  
}
extension ShowProductViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
      guard let cell = HairProductView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {fatalError("No cell found (line 104)")}
      cell.productName.text = hairProduct.results.name.capitalized
      if let description = hairProduct.results.features?.blob {
        cell.productDescriptionTextView.text = description
      }else {
        cell.productDescriptionTextView.text = hairProduct.results.description
      }
      if let urlString = hairProduct.results.images.first?.absoluteString{
        getProductImage(imageView: cell.productImage, urlString: urlString)
      }
      return cell
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
      return 1
  }
  }

extension ShowProductViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
      return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    
  }

}
