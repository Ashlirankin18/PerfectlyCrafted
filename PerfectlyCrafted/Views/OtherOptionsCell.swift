//
//  OtherOptionsCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class OtherOptionsCell: UICollectionViewCell {
  
  lazy var productImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "placeholder")
    return imageView
  }()
  lazy var sellerLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "Seller Label"
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 0
    return label
  }()
  lazy var urlLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "URL"
    label.textAlignment = .left
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 0
    return label
  }()
  lazy var priceLabel: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.textAlignment = .justified
    textView.isEditable = false
    textView.isScrollEnabled = false
    textView.text = "Price"
    textView.dataDetectorTypes = .link
    return textView
  }()
  override func layoutSubviews() {
    productImage.layer.masksToBounds = true
    productImage.layer.cornerRadius = 4
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    backgroundColor = .clear
    setUpViews()
  }
}
extension OtherOptionsCell{
  func setUpViews(){
    setUpProductImage()
    setUpSellerLabel()
    setUpPriceLabel()
    setUpURLLabel()
  }
  
  func setUpProductImage(){
    addSubview(productImage)
    productImage.translatesAutoresizingMaskIntoConstraints = false
    productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    productImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
    productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    productImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 80).isActive = true
    
  }
  func setUpSellerLabel(){
    addSubview(sellerLabel)
    sellerLabel.translatesAutoresizingMaskIntoConstraints = false
    sellerLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20).isActive = true
    sellerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
    sellerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    sellerLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
  }
  
  func setUpURLLabel(){
    addSubview(urlLabel)
    urlLabel.translatesAutoresizingMaskIntoConstraints = false
    urlLabel.topAnchor.constraint(equalTo:priceLabel.bottomAnchor, constant: 20).isActive = true
    urlLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    urlLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    urlLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }
  func setUpPriceLabel(){
    addSubview(priceLabel)
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 20).isActive = true
    priceLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    priceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    priceLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
  }
}
