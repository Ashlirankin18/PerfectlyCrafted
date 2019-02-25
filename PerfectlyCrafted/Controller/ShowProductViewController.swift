//
//  ShowProductViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ShowProductViewController: UIViewController {
  
  private var HairProduct: AllHairProducts!
  private var HairProductView: HairProductView!
  private var productImage = UIImage()
  init(hairProduct:AllHairProducts,view:HairProductView){
    super.init(nibName: nil, bundle: nil)
    self.HairProduct = hairProduct
    self.HairProductView = view
     let hairProductView = view
    self.view.addSubview(hairProductView)
    let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissPressed))
    navigationItem.leftBarButtonItem = backButton
    let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.title = "Category: \(hairProduct.results.category.capitalized)"
    navigationItem.largeTitleDisplayMode = .always
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = .white
      HairProductView.productCollectionView.delegate = self
       HairProductView.productCollectionView.dataSource = self
      setUpPresentationStyle()
    }
  @objc private func dismissPressed(){
    dismiss(animated: true, completion: nil)
  }
  @objc private func addButtonPressed(){
    print("add button Pressed")
  }
  func setUpPresentationStyle(){
    let transitionStyleStyle = UIModalTransitionStyle.crossDissolve
    self.modalTransitionStyle = transitionStyleStyle
    let presenttationStyle = UIModalPresentationStyle.currentContext
    self.modalPresentationStyle = presenttationStyle
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
}
extension ShowProductViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == HairProductView.productCollectionView{
      return 1
    }
    let otherOffers = HairProduct.results.sitedetails
    return otherOffers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == HairProductView.productCollectionView{
      guard let cell = HairProductView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {fatalError("No cell found (line 86)")}
      cell.productName.text = HairProduct.results.name.capitalized
      if let description = HairProduct.results.features?.blob {
        cell.productDescriptionTextView.text = description
      }else {
        cell.productDescriptionTextView.text = HairProduct.results.description
      }
      if let urlString = HairProduct.results.images.first?.absoluteString{
        getProductImage(imageView: cell.productImage, urlString: urlString)
      }
      cell.otherOptionsCollectionView.delegate = self
      cell.otherOptionsCollectionView.dataSource = self
      return cell
    }else {
      guard let cell = HairProductView.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell,
      let cellTwo = cell.otherOptionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as? OtherOptionsCell else {fatalError("no Productcell found")}
      let latestOffer = HairProduct.results.sitedetails[indexPath.row]
      
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
