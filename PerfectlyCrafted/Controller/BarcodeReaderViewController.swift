//
//  BarcodeReaderViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/12/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class BarcodeReaderViewController: UIViewController {

   lazy var vision = Vision.vision()
  var barCodeDetector: VisionBarcodeDetector?
  var imagePickerController : UIImagePickerController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.barCodeDetector = vision.barcodeDetector()
      view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1922914982, alpha: 1)
    
    }
    
  func setUpImagePickerController(){
    imagePickerController = UIImagePickerController()
    //imagePickerController.delegate = self
    if !UIImagePickerController.isSourceTypeAvailable(.camera){
      
    }else{
      
    }
  }
  
}
