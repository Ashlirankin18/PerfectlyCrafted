//
//  FirebaseProductModel.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/1/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct ProductModel:Codable {
  
  let productName: String
  let productId: String
  let productDescription: String
  var userId:String
  var productImage: String
  let category: String
  var isCompleted: Bool
  init(productName:String,productId:String,productDescription:String,userId:String,productImage:String,category:String,isCompleted:Bool){
  
    self.productName = productName
    self.productImage = productImage
    self.productId = productId
    self.productDescription = productDescription
    self.userId = userId
    self.category = category
    self.isCompleted = isCompleted
  }
  init(dict:[String:Any]) {
    self.productName = dict["productName"] as? String ?? "no product Name found"
    self.productId = dict["dbReference"] as? String ?? "no product Id found"
    self.productDescription = dict["productDescription"] as? String ?? "no product description found"
    self.userId = dict["userId"] as? String ?? "no user id was found"
    self.productImage = dict["productImage"] as? String ?? "no product url found"
    self.category = dict["category"] as? String ?? "no category found"
    self.isCompleted = dict["isCompleted"] as? Bool ?? false
  }
}

