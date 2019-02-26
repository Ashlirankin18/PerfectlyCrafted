//
//  ProductDataManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/25/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

class ProductDataManager {
  private static var products = [AllHairProducts]()
  
  static public func setProducts(products: [AllHairProducts]) {
    self.products = products
  }
  
  static public func getProducts() -> [AllHairProducts] {
    return self.products
  }
}
