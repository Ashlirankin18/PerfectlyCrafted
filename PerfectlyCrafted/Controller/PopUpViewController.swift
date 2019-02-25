//
//  PopUpViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase

class PopUpViewController: UIViewController {
  
  let popUpView = PopUpView()
  var imagePickerController: UIImagePickerController!
  lazy var vision = Vision.vision()
  var barcodeDetector: VisionBarcodeDetector?
  var allHairProducts = [AllHairProducts](){
    didSet{
      print("I am set and I have \(allHairProducts.count) items (line 20)")
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(popUpView)
    view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    setUpPresentationStyle()
    setUpImagePickerController()
    self.barcodeDetector = vision.barcodeDetector()
    getAllHairProducts()
    addingActionsToButtons()
  }
  func setUpPresentationStyle(){
    let transitionStyleStyle = UIModalTransitionStyle.coverVertical
    self.modalTransitionStyle = transitionStyleStyle
    let presenttationStyle = UIModalPresentationStyle.popover
    self.modalPresentationStyle = presenttationStyle
  }
  private func setUpImagePickerController(){
    imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    
  }
  private func showImagePickerController(){
    self.present(imagePickerController, animated: true, completion: nil)
  }
  private func getAllHairProducts(){
    HairProductApiClient.getHairProducts { (error, allHairProducts) in
      if let error = error {
        print(error.errorMessage())
      }
      if let allHairProducts = allHairProducts{
        self.allHairProducts = allHairProducts
      }
    }
  }
    func getProductFromBarcode(barcodeNumber:String) -> AllHairProducts? {
      let product = allHairProducts.first{$0.results.upc == barcodeNumber}
      return product
    }
  
  
  private func openCamera(){
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = .camera
      present(myPickerController, animated: true, completion: nil)
    }
  }
  func addingActionsToButtons(){
    popUpView.addFromCameraButton.addTarget(self, action: #selector(presentCameraOption), for: .touchUpInside)
    popUpView.addFromGalleryButton.addTarget(self, action: #selector(presentGalleryOption), for: .touchUpInside)
    popUpView.searchForProductButton.addTarget(self, action: #selector(presentSearchBar), for: .touchUpInside)
  }
  
  @objc func presentCameraOption(){
    openCamera()
  }
  @objc func presentGalleryOption(){
    showImagePickerController()
  }
  @objc func presentSearchBar(){
    let searchController = SearchProductViewController.init(allHairProducts: allHairProducts)
    let navigationController = UINavigationController.init(rootViewController: searchController)
    navigationController.modalPresentationStyle = .currentContext
    navigationController.modalTransitionStyle = .crossDissolve
    navigationController.definesPresentationContext = true
    self.present(navigationController, animated: true, completion: nil)
  }
  
  func makeCallToBarcodeDetector(image:UIImage?){
        if let barcodeReader = self.barcodeDetector {
          if let image = image {
             let visionImage = VisionImage(image: image)
            barcodeReader.detect(in: visionImage, completion: { (barcodes, error) in
              if let error = error{
                print(error.localizedDescription)
              }
              else if let barcodes = barcodes {
                for barcode in barcodes {
                  if let barcodeNumber = barcode.rawValue{
                    if let product = self.getProductFromBarcode(barcodeNumber: barcodeNumber){
                      let productViewController = ShowProductViewController.init(hairProduct: product, view: HairProductView())
                      let navController = UINavigationController(rootViewController: productViewController)
                      self.present(navController, animated: true, completion: nil)
                    }else{
                      print("no product was found")
                    }
                  } else if let barcode = barcode.rawValue?.isEmpty {
                    print("no \(barcode) number found")
                  }
                }
              }
            })
          }else{
            print("no image was found")
          }
          
        }else {
            print("barcode reader not found")
    }
  }
}
  

extension PopUpViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let productImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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


