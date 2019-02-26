//
//  DatabaseManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/25/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DataBaseManager {
  private init(){}
  
  static let firebaseDB: Firestore = {
    let db = Firestore.firestore()
    return db
  }()
  
  
}
