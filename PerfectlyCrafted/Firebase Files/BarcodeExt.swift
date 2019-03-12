//
//  BarcodeExt.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/12/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase
extension HairProductsTableViewController{

  func getProductFromBarcode(barcodeNumber:String) -> AllHairProducts? {
    let product = self.allHairProducts.first{$0.results.upc == barcodeNumber}
    return product
  }
  
  public func makeCallToBarcodeDetector(image:UIImage?){
    if let barcodeReader = self.barcodeDetector {
      if let image = image {
        let visionImage = VisionImage(image: image)
        barcodeReader.detect(in: visionImage, completion: { [weak self] (barcodes, error) in
          if let error = error{
            print(error.localizedDescription)
          }
          else if let barcodes = barcodes {
            for barcode in barcodes {
              if let barcodeNumber = barcode.rawValue{
                if let product = self?.getProductFromBarcode(barcodeNumber: barcodeNumber){
                  let productViewController = ShowProductViewController.init(hairProduct: product, view: HairProductView())
                  let navController = UINavigationController(rootViewController: productViewController)
                  self?.present(navController, animated: true, completion: nil)
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
