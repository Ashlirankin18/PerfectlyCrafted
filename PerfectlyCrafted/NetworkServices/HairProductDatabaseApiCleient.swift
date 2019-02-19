//
//  HairProductDatabaseApiCleient.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/18/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
final class HairProductApiClient{
  private init(){}
  
  static func getHairProducts(completionHandler: @escaping (AppError?, [AllHairProducts]?) -> Void){
    let urlString = "http://5c671eba24e2140014f9ee6d.mockapi.io/api/v1/hairProducts"
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
      if let error = error{
        completionHandler(AppError.badURL(error.errorMessage()),nil)
      }
      if let data = data{
        do{
          let hairProducts = try JSONDecoder().decode([AllHairProducts].self, from: data)
          completionHandler(nil,hairProducts)
        }catch{
          completionHandler(AppError.decodingError(error),nil)
        }
      }
    }
  }
  
}
