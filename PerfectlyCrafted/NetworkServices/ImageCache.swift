//
//  ImageCache.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

final class ImageCache {
  private init() {}
  
  static let shared = ImageCache()
  
  private static var cache = NSCache<NSString, UIImage>()
  
  public func fetchImageFromNetwork(urlString: String, completion: @escaping (AppError?, UIImage?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
      
    
      if let error = error {
        DispatchQueue.main.async {
          completion(error, nil)
        }
      } else if let data = data {
        DispatchQueue.global().async {
          if let image = UIImage(data: data) {
            ImageCache.cache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
              completion(nil, image)
            }
          }
        }
      }
    }
  }
  
  public func fetchImageFromCache(urlString: String) -> UIImage? {
    return ImageCache.cache.object(forKey: urlString as NSString)
}



// Example Use Case:
/*
 if let image = ImageCache.shared.fetchImageFromCache(urlString: photoURL.absoluteString) {
 profileImageButton.setImage(image, for: .normal)
 } else {
 ImageCache.shared.fetchImageFromNetwork(urlString: photoURL.absoluteString) { (appError, image) in
 if let appError = appError {
 self.showAlert(title: "Fetching Image Error", message: appError.errorMessage())
 } else if let image = image {
 self.profileImageButton.setImage(image, for: .normal)
 }
 }
 }
 */

}
