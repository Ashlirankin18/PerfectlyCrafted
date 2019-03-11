//
//  FeedModel.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
struct FeedModel {
  let feedId: String
  let userId: String
  let userImageLink:String
  let productId:String?
  let imageURL:String
  let caption:String
  let userName:String
  let datePosted: String
  init(feedId:String,userId:String,userImageLink:String,productId:String,imageURL:String,caption:String,userName:String,datePosted:String){
    self.feedId = feedId
    self.userId = userId
    self.userImageLink = userImageLink
    self.productId = productId
    self.imageURL = imageURL
    self.caption = caption
    self.userName = userName
    self.datePosted = datePosted
  }
  init(dict:[String:Any]){
    self.feedId = dict["feedId"] as? String ?? "no feed id found"
    self.userId = dict["userId"] as? String ?? "no user id found"
    self.userImageLink = dict["userImage"] as? String ?? "no userImage found"
    self.productId = dict["productId"] as? String ?? "no product id found"
    self.imageURL = dict["imageUrl"] as? String ?? "no image url found"
    self.caption = dict["caption"] as? String ?? "no caption found "
    self.userName = dict["userName"] as? String ?? "no userName found"
    self.datePosted = dict["datePosted"] as? String ?? " no date found"
}
}
