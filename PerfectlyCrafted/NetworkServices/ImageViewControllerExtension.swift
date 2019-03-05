//
//  ImageViewControllerExtension.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
extension UIViewController {
  func getImage(ImageView:UIImageView,imageURLString:String){
    if let image = ImageCache.shared.fetchImageFromCache(urlString: imageURLString){
      DispatchQueue.main.async {
        ImageView.image = image
      }
      
    }else{
      ImageCache.shared.fetchImageFromNetwork(urlString: imageURLString) { (error, image) in
        if let error = error{
          print(error.errorMessage())
        }
        else if let image = image {
          DispatchQueue.main.async {
            ImageView.image = image
          }
        }
      }
    }
  }
}
