//
//  UserPersistanceHelper.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
final class UserPersistanceHelper {
  private static let fileName = "Users.plist"
  private static var usersArray = [User]()
  
  static func getUsersInfo() -> [User] {
    let path = DataPersistanceManager.filePathToDocumentsDirectory(fileName: fileName).path
    if FileManager.default.fileExists(atPath: path){
      if let data = FileManager.default.contents(atPath: path){
        do{
          usersArray = try PropertyListDecoder().decode([User].self, from: data)
        }catch{
          print("No users found")
        }
      }
    }else{
      print("\(fileName) does not exist")
    }
    return usersArray
  }
  static func saveUser(){
    let path = DataPersistanceManager.filePathToDocumentsDirectory(fileName: fileName)
    do{
      let data = try PropertyListEncoder().encode(usersArray)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    }catch{
      print("Property List Encoding Error")
    }
  }
  
  static func addToDocumentsDirectory(user:User){
    usersArray.append(user)
    saveUser()
  }
 static func updateUserData(user:User,index:Int){
    usersArray.insert(user, at: index)
    saveUser()
  }
  
  static func deleteUser(index:Int){
    usersArray.remove(at: index)
    saveUser()
  }
  
  
}
