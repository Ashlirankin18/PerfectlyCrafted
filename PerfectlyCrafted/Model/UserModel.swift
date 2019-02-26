//
//  UserModel.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct UserModel:Codable {
  let userName:String
  let email:String
  let profileImageLink: String?
  let hairType: String?
  let aboutMe: String
  let userId: String
init(userName:String,email:String,profileImageLink:String,hairType:String,aboutMe:String,userId:String){
    self.userName = userName
    self.email = email
    self.profileImageLink = profileImageLink
    self.hairType = hairType
    self.aboutMe = aboutMe
    self.userId = userId
  }

  init(dict:[String:Any]) {
    self.userName = dict["userName"] as? String ?? "no user name found"
    self.email = dict["email"] as? String ?? "no email address found"
    self.profileImageLink = dict["profileImageLink"] as? String ?? "no profile link found"
    self.hairType = dict["hairType"] as? String ?? "no hair type found"
    self.aboutMe = dict["aboutMe"] as? String ?? "no hair type found"
    self.userId = dict["userId"] as? String ?? "no user Id Found"
  }
}
