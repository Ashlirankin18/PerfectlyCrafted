//
//  PersistanceManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
final class DataPersistanceManager {
  private init(){}
  static func documentsDirectory() -> URL{
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  static func filePathToDocumentsDirectory(fileName:String) -> URL {
    return documentsDirectory().appendingPathComponent(fileName)
  }
  
}
