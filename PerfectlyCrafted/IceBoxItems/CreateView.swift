//
//  CreatView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/8/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class CreateView: UIView {

  lazy var productImage:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "placeholder"), for: .normal)
    return button
  }()
  lazy var ratingOne:UIButton = {
    let button = UIButton()
    button.tag = 1
    button.setImage(#imageLiteral(resourceName: "icons8-star-25.png"), for: .normal)
    return button
  }()
  lazy var ratingTwo:UIButton = {
    let button = UIButton()
    button.tag = 2
    button.setImage(#imageLiteral(resourceName: "icons8-star-25.png"), for: .normal)
    return button
  }()
  lazy var ratingThree:UIButton = {
    let button = UIButton()
    button.tag = 3
    button.setImage(#imageLiteral(resourceName: "icons8-star-25.png"), for: .normal)
    return button
  }()
  lazy var ratingFour:UIButton = {
    let button = UIButton()
    button.tag = 4
   button.setImage(#imageLiteral(resourceName: "icons8-star-25.png"), for: .normal)
    return button
  }()
  lazy var ratingFive:UIButton = {
    let button = UIButton()
    button.tag = 5
    button.setImage(#imageLiteral(resourceName: "icons8-star-25.png"), for: .normal)
    return button
  }()
  lazy var ratingDetailedView:UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  lazy var productNameTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .black
    textField.borderStyle = .roundedRect
    return textField
  }()
  lazy var productNameLabel:UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "ProductName"
    label.backgroundColor = .black
    return label
  }()
  lazy var productDescriptionTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .black
    textView.textColor = .white
    textView.text = "Your review goes here"
    return textView
  }()
  lazy var categoryTag1:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#Shampoo", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
     button.titleLabel?.numberOfLines = 0
    return button
  }()
  lazy var categoryTag2:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#Conditioner", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.numberOfLines = 0
    return button
  }()
  lazy var categoryTag3:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#DeepConditioner", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
     button.titleLabel?.numberOfLines = 0
    return button
  }()
  lazy var categoryTag4:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#HairOil", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.numberOfLines = 0
    return button
  }()
  lazy var categoryTag5:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#HairTool", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.numberOfLines = 0
    return button
  }()
  lazy var categoryTag6:UIButton = {
    let button = UIButton()
    button.tag = 0
    button.setTitle("#Avacado", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.numberOfLines = 0
    return button
  }()
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    setUpViews()
    backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
  }
  func setUpViews(){
   setNewImage()
  }
  
}
extension CreateView {
  func setNewImage(){
    setUpProductImage()
    setUpRatingButtonConstraints()
    ratingTwoConstraints()
    ratingThreeConstraints()
    ratingFourConstraints()
    ratingFiveConstraints()
    setUpDetailledView()
    setNeedsProductNameLabel()
    setNeedsProductNameTextField()
    setProductDescriptionTextfield()
    categoryPickerConstraints()
    category2PickerConstraints()
    category3PickerConstraints()
    category4PickerConstraints()
    category5PickerConstraints()
  }
  
  func setUpProductImage(){
    addSubview(productImage)
    productImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: productImage, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 40).isActive = true
    NSLayoutConstraint.init(item: productImage, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 50).isActive = true
    NSLayoutConstraint(item: productImage, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -50).isActive = true
    NSLayoutConstraint(item: productImage, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 0.5, constant: 0).isActive = true
  }
  func setUpRatingButtonConstraints(){
    addSubview(ratingOne)
    ratingOne.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingOne, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingOne, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 110).isActive = true
  }
  func ratingTwoConstraints() {
    addSubview(ratingTwo)
    ratingTwo.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingTwo, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingTwo, attribute: .leading, relatedBy: .equal, toItem: ratingOne, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  
  func ratingThreeConstraints() {
    addSubview(ratingThree)
    ratingThree.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingThree, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingThree, attribute: .leading, relatedBy: .equal, toItem: ratingTwo, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func ratingFourConstraints() {
    addSubview(ratingFour)
    ratingFour.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingFour, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFour, attribute: .leading, relatedBy: .equal, toItem: ratingThree, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func ratingFiveConstraints() {
    addSubview(ratingFive)
    ratingFive.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: ratingFive, attribute: .top, relatedBy: .equal, toItem: productImage, attribute: .bottom, multiplier: 1.0, constant: 12).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint.init(item: ratingFive, attribute: .leading, relatedBy: .equal, toItem: ratingFour, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func setUpDetailledView(){
    addSubview(ratingDetailedView)
    ratingDetailedView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: ratingDetailedView, attribute: .top, relatedBy: .equal, toItem: ratingOne, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint(item: ratingDetailedView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: ratingDetailedView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    NSLayoutConstraint(item: ratingDetailedView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
  }
  func setNeedsProductNameLabel(){
    addSubview(productNameLabel)
    productNameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: productNameLabel, attribute: .top, relatedBy: .equal, toItem: ratingDetailedView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: productNameLabel, attribute: .leading, relatedBy: .equal, toItem: ratingDetailedView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
     NSLayoutConstraint(item: productNameLabel, attribute: .trailing, relatedBy: .equal, toItem: ratingDetailedView, attribute: .trailing, multiplier: 1.0, constant: -265).isActive = true
     NSLayoutConstraint(item: productNameLabel, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 10).isActive = true
  }
  func setNeedsProductNameTextField(){
    addSubview(productNameTextField)
    productNameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: productNameTextField, attribute: .top, relatedBy: .equal, toItem: ratingDetailedView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: productNameTextField, attribute: .leading, relatedBy: .equal, toItem: productNameLabel, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: productNameTextField, attribute: .trailing, relatedBy: .equal, toItem: ratingDetailedView, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    NSLayoutConstraint(item: productNameTextField, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 10).isActive = true
  }
  
  func setProductDescriptionTextfield(){
    addSubview(productDescriptionTextView)
    productDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: productDescriptionTextView, attribute: .top, relatedBy: .equal, toItem: productNameLabel, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
    NSLayoutConstraint(item: productDescriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: ratingDetailedView, attribute: .bottom, multiplier: 1.0, constant: -100).isActive = true
    NSLayoutConstraint(item: productDescriptionTextView, attribute: .leading, relatedBy: .equal, toItem: ratingDetailedView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
     NSLayoutConstraint(item: productDescriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: ratingDetailedView, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
  }
  func categoryPickerConstraints() {
    addSubview(categoryTag1)
    categoryTag1.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: categoryTag1, attribute: .top, relatedBy: .equal, toItem: productDescriptionTextView, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: categoryTag1, attribute: .width, relatedBy: .equal, toItem: ratingOne, attribute: .width, multiplier: 1.0, constant: 60).isActive = true
    NSLayoutConstraint.init(item: categoryTag1, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: categoryTag1, attribute: .leading, relatedBy: .equal, toItem: ratingDetailedView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
  }
  
  func category2PickerConstraints() {
    addSubview(categoryTag2)
    categoryTag2.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: categoryTag2, attribute: .top, relatedBy: .equal, toItem: productDescriptionTextView, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: categoryTag2, attribute: .width, relatedBy: .equal, toItem: ratingOne, attribute: .width, multiplier: 1.0, constant: 80).isActive = true
    NSLayoutConstraint.init(item: categoryTag2, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: categoryTag2, attribute: .leading, relatedBy: .equal, toItem: categoryTag1, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func category3PickerConstraints() {
    addSubview(categoryTag3)
    categoryTag3.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: categoryTag3, attribute: .top, relatedBy: .equal, toItem: productDescriptionTextView, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: categoryTag3, attribute: .width, relatedBy: .equal, toItem: ratingOne, attribute: .width, multiplier: 1.0, constant: 120).isActive = true
    NSLayoutConstraint.init(item: categoryTag3, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: categoryTag3, attribute: .leading, relatedBy: .equal, toItem: categoryTag2, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  func category4PickerConstraints() {
    addSubview(categoryTag4)
    categoryTag4.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: categoryTag4, attribute: .top, relatedBy: .equal, toItem: categoryTag1, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: categoryTag4, attribute: .width, relatedBy: .equal, toItem: ratingOne, attribute: .width, multiplier: 1.0, constant: 60).isActive = true
    NSLayoutConstraint.init(item: categoryTag4, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: categoryTag4, attribute: .leading, relatedBy: .equal, toItem: ratingDetailedView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
  }
  func category5PickerConstraints() {
    addSubview(categoryTag5)
    categoryTag5.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.init(item: categoryTag5, attribute: .top, relatedBy: .equal, toItem: categoryTag2, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
    NSLayoutConstraint.init(item: categoryTag5, attribute: .width, relatedBy: .equal, toItem: ratingOne, attribute: .width, multiplier: 1.0, constant: 80).isActive = true
    NSLayoutConstraint.init(item: categoryTag5, attribute: .height, relatedBy: .equal, toItem: ratingOne, attribute: .height, multiplier: 1.0, constant: 20).isActive = true
    NSLayoutConstraint.init(item: categoryTag5, attribute: .leading, relatedBy: .equal, toItem: categoryTag4, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
  }
  
}
