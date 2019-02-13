//
//  CurrentUser.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

final class UserSession{
  private init(){}
  static let shared = UserSession()
  static var user: User?
  static func currentUser(userName:String,password:String) -> User?{
    if let currentUser = UserPersistanceHelper.getUsersInfo().first(where: { (user) -> Bool in
      user.userName == userName && user.password == password
    }){
      user = currentUser
      return user
    } else {
      return nil
    }
   
}
}
