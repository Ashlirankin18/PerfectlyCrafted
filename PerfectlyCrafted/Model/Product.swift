//
//  Product.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import Foundation

struct Product: Codable {
    
    let category: String
    let experience: String
    let documentId: String
    let isFinished: Bool
    let name: String
    let purchaseLocation: String
    let imageURLS: [String]
    
    init(category: String, experience: String, documentId: String, isFinished: Bool, name: String, purchaseLocation: String, imageURLS: [String]) {
        self.category = category
        self.experience = experience
        self.documentId = documentId
        self.isFinished = isFinished
        self.name = name
        self.purchaseLocation = purchaseLocation
        self.imageURLS = imageURLS
    }
    
    init(dict: [String: Any]) {
        self.category = dict["category"] as? String ?? "Un-categorized"
        self.experience = dict["experience"] as? String ?? ""
        self.documentId = dict["documentId"] as? String ?? ""
        self.isFinished = dict["isFinished"] as? Bool ?? false
        self.name = dict["name"] as? String ?? ""
        self.purchaseLocation = dict["purchaseLocation"] as? String ?? ""
        self.imageURLS = dict["imageURLS"] as? [String] ?? []
    }
}
