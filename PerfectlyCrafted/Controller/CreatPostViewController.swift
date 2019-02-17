//
//  CreatPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/6/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase
class CreatPostViewController: UIViewController {

  let createView = CreateView()
  var imageWithBarcode = UIImage()
  
  var tapGesture: UITapGestureRecognizer!
  var imagePickerController: UIImagePickerController!
  lazy var vision = Vision.vision()
  var barcodeDetector: VisionBarcodeDetector?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    view.addSubview(createView)
      setUpImagePickerController()
    setUpProfileImage()
      self.barcodeDetector = vision.barcodeDetector()
    
    }
  
  private func setUpImagePickerController(){
    imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    
  }
  private func openCamera(){
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = .camera
     present(myPickerController, animated: true, completion: nil)
    }
  }
  private func showImagePickerController(){
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
  func setUpProfileImage(){
    createView.productImage.addTarget(self, action: #selector(productImagePressed), for: .touchUpInside)
  }
  
  
  @objc func productImagePressed(){
    let actionSheet = UIAlertController(title: "Add a Product", message: "How would you like to add a product", preferredStyle: .actionSheet)
    let addBarcode = UIAlertAction(title: "Take Picture of Barcode", style: .default){ done in
      if !UIImagePickerController.isSourceTypeAvailable(.camera){
        let cameraAction =  actionSheet.actions.first { (action) -> Bool in
          action.title == "Take Picture of Barcode"
        }
        cameraAction?.isEnabled = false
      }else {
        self.openCamera()
      }
    }
    let chooseFromLibrary = UIAlertAction(title: "Add from Gallery", style: .default) { (done) in
      self.showImagePickerController()
      
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { done in
      
    }
    
    actionSheet.addAction(addBarcode)
    actionSheet.addAction(chooseFromLibrary)
    actionSheet.addAction(cancelAction)
    self.present(actionSheet, animated: true, completion: nil)

  }
  
  func makeCallToBarcodeDetector(image:UIImage?){
    if let productImage = self.createView.productImage.currentImage {
      if productImage != #imageLiteral(resourceName: "placeholder") {
        if let barcodeReader = self.barcodeDetector{
          let visionImage = VisionImage(image: productImage)
          barcodeReader.detect(in: visionImage, completion: { (barcodes, error) in
            if let error = error{
              print(error.localizedDescription)
            }
            else if let barcodes = barcodes {
              for barcode in barcodes {
                print(barcode.rawValue!)
                self.createView.productDescriptionTextView.text = barcode.displayValue!
              }
            }
          })
        }else {
          print("barcode reader not found")
        }
      }else {
        print("it is placeholder image")
      }
    }else {
      print("No image found")
    }
  }
}
extension CreatPostViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let productImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      createView.productImage.setImage(productImage, for: .normal)
      makeCallToBarcodeDetector(image: productImage)
    } else {
      print("No image was found")
    }
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
