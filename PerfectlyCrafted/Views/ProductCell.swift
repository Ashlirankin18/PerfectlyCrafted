//
//  ProductCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
  lazy var productImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "placeholder")
    return imageView
  }()
  lazy var productName: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "Product Name"
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  lazy var productDescriptionTextView:UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = true
    textView.text = "this is a test"
    return textView
  }()
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    setUpViews()
    backgroundColor = .clear
  }
  override func layoutSubviews() {
    productImage.layer.masksToBounds = true
    productImage.layer.cornerRadius = 4
  }
}
extension ProductCell{
  func setUpViews(){
    setUpProductName()
    setUpProductImage()
    setUpProductDescription()
 
  }
 
  func setUpProductName(){
    addSubview(productName)
    productName.translatesAutoresizingMaskIntoConstraints = false
    
    productName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    productName.widthAnchor.constraint(equalToConstant: 300).isActive = true
    productName.heightAnchor.constraint(equalToConstant: 60).isActive = true
    productName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
    
  }
  func setUpProductImage(){
    addSubview(productImage)
    productImage.translatesAutoresizingMaskIntoConstraints = false
    productImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
    productImage.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 30).isActive = true
    productImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
    productImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
  }
  func setUpProductDescription(){
    addSubview(productDescriptionTextView)
    productDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    productDescriptionTextView.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20).isActive = true
    productDescriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    productDescriptionTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    productDescriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
    
  }
 
  

}
