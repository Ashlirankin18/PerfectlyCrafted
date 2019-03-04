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
  let productImage: String
  let category: String
}
