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
  let dbReferenceDocumentId: String
  init(userName:String,email:String,profileImageLink:String,hairType:String,aboutMe:String,userId:String,dbReferenceDocumentId:String){
    self.userName = userName
    self.email = email
    self.profileImageLink = profileImageLink
    self.hairType = hairType
    self.aboutMe = aboutMe
    self.userId = userId
    self.dbReferenceDocumentId = dbReferenceDocumentId
  }

  init(dict:[String:Any]) {
    self.userName = dict["userName"] as? String ?? "no user name found"
    self.email = dict["email"] as? String ?? "no email address found"
    self.profileImageLink = dict["imageURL"] as? String ?? "no profile link found"
    self.hairType = dict["hairType"] as? String ?? "no hair type found"
    self.aboutMe = dict["bio"] as? String ?? "no bio found"
    self.userId = dict["userId"] as? String ?? "no user Id Found"
    self.dbReferenceDocumentId = dict["dbReferenceDocumentId"] as? String ?? "no document id found"
  }
}
