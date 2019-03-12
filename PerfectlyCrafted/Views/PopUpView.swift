//
//  PopUpView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PopUpView: UIView {
  

  lazy var popUpView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.51)
    view.layer.cornerRadius = 10
    view.layer.masksToBounds = true
    return view
  }()
  lazy var addFromCameraButton:UIButton = {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "icons8-screenshot-filled-25"), for: .normal)
   
    return button
  }()
  lazy var addFromCameraLabel:UILabel = {
    let label = UILabel()
    label.text = "Take Picture"
    return label
  }()
  lazy var addFromGalleryButton:UIButton =  {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "icons8-picture-25"), for: .normal)
    return button
  }()
  lazy var addFromGalleryLabel:UILabel =  {
    let label = UILabel()
    label.text = "Add from Gallery"
    return label
  }()
  lazy var searchForProductButton:UIButton =  {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "icons8-search-25"), for: .normal)
    return button
  }()
  lazy var searchForProductButtonLabel:UILabel =  {
    let label = UILabel()
    label.text = "Search for product"
    return label
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
  }
 
}
extension PopUpView {
  func setUpViews(){
    setUpPopUpView()
    setUpProductChoicesConstraints()
  }
  
  func setUpPopUpView(){
  addSubview(popUpView)
    popUpView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: popUpView, attribute: .centerX, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: popUpView, attribute: .centerY, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: popUpView, attribute: .width, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
    NSLayoutConstraint(item: popUpView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
    
    
  }
  func setUpProductChoicesConstraints(){
    setUpTakeFromcameraButtonConstraints()
    setUpTakeFromcameraLabelConstraints()
    setUpAddFromGalleryButtonConstraints()
    setUpAddFromGalleryLabelConstraints()
    searchButtonConstraints()
    setUpSearchLabel()
  }
  func setUpTakeFromcameraButtonConstraints(){
    addSubview(addFromCameraButton)
    addFromCameraButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: addFromCameraButton, attribute: .top, relatedBy: .equal, toItem: popUpView, attribute: .top, multiplier: 1.4, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromCameraButton, attribute: .trailing, relatedBy: .equal, toItem: popUpView, attribute: .trailing, multiplier: 0.9, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromCameraButton, attribute: .height, relatedBy: .equal, toItem: addFromCameraButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpTakeFromcameraLabelConstraints(){
    addSubview(addFromCameraLabel)
    addFromCameraLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: addFromCameraLabel, attribute: .top, relatedBy: .equal, toItem: popUpView, attribute: .top, multiplier: 1.4, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromCameraLabel, attribute: .trailing, relatedBy: .equal, toItem: addFromCameraButton, attribute: .leading, multiplier: 0.9, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromCameraLabel, attribute: .leading, relatedBy: .equal, toItem: popUpView, attribute: .leading, multiplier: 1.4, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromCameraLabel, attribute: .height
      , relatedBy: .equal, toItem: addFromCameraLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpAddFromGalleryButtonConstraints(){
    addSubview(addFromGalleryButton)
    addFromGalleryButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: addFromGalleryButton, attribute: .top, relatedBy: .equal, toItem: addFromCameraButton, attribute: .top, multiplier: 1.2 , constant: 0).isActive = true
    NSLayoutConstraint(item: addFromGalleryButton, attribute: .trailing, relatedBy: .equal, toItem: popUpView, attribute: .trailing, multiplier: 0.9 , constant: 0).isActive = true
     NSLayoutConstraint(item: addFromGalleryButton, attribute: .height, relatedBy: .equal, toItem: addFromGalleryButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  func setUpAddFromGalleryLabelConstraints(){
    addSubview(addFromGalleryLabel)
    addFromGalleryLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: addFromGalleryLabel, attribute: .top, relatedBy: .equal, toItem: addFromCameraLabel, attribute: .top, multiplier: 1.2, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromGalleryLabel, attribute: .trailing, relatedBy: .equal, toItem: addFromGalleryButton, attribute: .leading, multiplier: 0.9, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromGalleryLabel, attribute: .leading, relatedBy: .equal, toItem: popUpView, attribute: .leading, multiplier: 1.4, constant: 0).isActive = true
    NSLayoutConstraint(item: addFromGalleryLabel, attribute: .height, relatedBy: .equal, toItem: addFromGalleryLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
  }
  
  func setUpSearchLabel(){
    addSubview(searchForProductButtonLabel)
    searchForProductButtonLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: searchForProductButtonLabel, attribute: .top, relatedBy: .equal, toItem: addFromGalleryLabel, attribute: .bottom, multiplier: 1.1, constant: 0).isActive = true
    NSLayoutConstraint(item: searchForProductButtonLabel, attribute: .trailing, relatedBy: .equal, toItem: searchForProductButton, attribute: .leading, multiplier: 0.9, constant: 0).isActive = true
    NSLayoutConstraint(item: searchForProductButtonLabel, attribute: .leading, relatedBy: .equal, toItem: popUpView, attribute: .leading, multiplier: 1.4, constant: 0).isActive = true
  }
  func searchButtonConstraints(){
addSubview(searchForProductButton)
searchForProductButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: searchForProductButton, attribute: .top, relatedBy: .equal, toItem: addFromGalleryButton, attribute: .bottom, multiplier: 1.1, constant: 0).isActive = true
    NSLayoutConstraint(item: searchForProductButton, attribute: .trailing, relatedBy: .equal, toItem: popUpView, attribute: .trailing, multiplier: 0.9 , constant: 0).isActive = true
   NSLayoutConstraint(item: searchForProductButton, attribute: .height, relatedBy: .equal, toItem: searchForProductButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    
  }
  
}
