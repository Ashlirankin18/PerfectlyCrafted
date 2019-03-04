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
    navigationItem.largeTitleDisplayMode = .always
  }
  @objc private func dismissPressed(){
    dismiss(animated: true, completion: nil)
  }
  @objc private func addButtonPressed(){
    let theCurrentHairProduct = hairProduct.results
    guard let user = userSession.getCurrentUser(), let imageUrl =  theCurrentHairProduct.images.first?.absoluteString else {return}
    let category = theCurrentHairProduct.category
    let product = ProductModel.init(productName: theCurrentHairProduct.name, productId: "", productDescription: theCurrentHairProduct.description, userId: user.uid, productImage: imageUrl, category: category)
    DataBaseManager.postProductToDatabase(product: product, user: user)
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
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == HairProductView.productCollectionView{
      return 1
    }
    let otherOffers = hairProduct.results.sitedetails
    return otherOffers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == HairProductView.productCollectionView{
      guard let cell = HairProductView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {fatalError("No cell found (line 86)")}
      cell.productName.text = hairProduct.results.name.capitalized
      if let description = hairProduct.results.features?.blob {
        cell.productDescriptionTextView.text = description
      }else {
        cell.productDescriptionTextView.text = hairProduct.results.description
      }
      
      
      if let urlString = hairProduct.results.images.first?.absoluteString{
        getProductImage(imageView: cell.productImage, urlString: urlString)
      }
      cell.otherOptionsCollectionView.delegate = self
      cell.otherOptionsCollectionView.dataSource = self
      return cell
    }else {
      guard let cell = HairProductView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell,
      let cellTwo = cell.otherOptionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as? OtherOptionsCell else {fatalError("no Productcell found")}
      let latestOffer = hairProduct.results.sitedetails[indexPath.row]
      
      cellTwo.productImage.image = productImage
    
      if let seller = latestOffer.latestoffers.first?.seller {
        cellTwo.sellerLabel.text = seller
      }else{
        cellTwo.sellerLabel.text = "Seller name not found"
      }
      if let price = latestOffer.latestoffers.first?.price{
        cellTwo.priceLabel.text = " Price: $\(price)"
      }else{
        cellTwo.priceLabel.text = "No price found"
      }
      
      cellTwo.urlLabel.text = "\(latestOffer.url)"
      print(latestOffer.url)
      return cellTwo
    }
    }
 
  }

extension ShowProductViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == HairProductView.productCollectionView {
      return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }else{
      return CGSize.init(width: 250, height: 300)
    }
  }

}
