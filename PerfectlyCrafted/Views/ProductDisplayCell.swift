//
//  ProductDisplayCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/20/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ProductDisplayCell: UITableViewCell {

  lazy var productImage:UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "placeholder")
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 5
    return imageView
  }()
  lazy var dividerView:UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return view
  }()
  lazy var productName: UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.text = "Product Name"
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  lazy var categoryLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.text = "Product Name"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.layer.masksToBounds = true
    label.adjustsFontSizeToFitWidth = true
    label.layer.cornerRadius = 5
    label.layer.borderWidth = 3
    label.layer.borderColor = UIColor.lightGray.cgColor
    return label
  }()
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: "DisplayCell")
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    setUpViews()
  }
  
}
extension ProductDisplayCell{
  func setUpViews(){
    setUpImageView()
    setUpDividerView()
    setUpProductNameConstraints()
    setUpCategoryLabel()
  }
  func setUpImageView(){
    addSubview(productImage)
    productImage.translatesAutoresizingMaskIntoConstraints = false
    productImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 14).isActive = true
    productImage.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.4).isActive = true
    productImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
    productImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
  }
  func setUpDividerView(){
    addSubview(dividerView)
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.leadingAnchor.constraint(equalToSystemSpacingAfter: productImage.trailingAnchor, multiplier: 1.4).isActive = true
    dividerView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.4).isActive = true
    dividerView.widthAnchor.constraint(equalToConstant: 3).isActive = true
    dividerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
  }
  func setUpProductNameConstraints(){
    addSubview(productName)
    productName.translatesAutoresizingMaskIntoConstraints = false
    productName.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 1.0).isActive = true
    productName.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.4).isActive = true
    productName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    productName.widthAnchor.constraint(equalToConstant: 300).isActive = true
  }
  func setUpCategoryLabel(){
    addSubview(categoryLabel)
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.topAnchor.constraint(equalToSystemSpacingBelow: productName.bottomAnchor, multiplier: 1.2).isActive = true
    categoryLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 1.0).isActive = true
    categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    categoryLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
  }
}
