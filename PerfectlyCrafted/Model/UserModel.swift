//
//  UserModel.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
struct User:Codable {
  let userName:String
  let password:String
  let email:String
  let profileImage:Data?
  let fullName:String?
  let dateOfBirth:Date?
}
