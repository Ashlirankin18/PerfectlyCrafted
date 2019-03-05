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
    let settings = db.settings
    settings.areTimestampsInSnapshotsEnabled = true
    db.settings = settings
    return db
  }()
  
  static func postUserToDatabase(user:UserModel){
    var ref: DocumentReference? = nil
    ref = firebaseDB.collection(FirebaseCollectionKeys.users).addDocument(data: [
      "userName":user.userName,
      "hairType":user.hairType!,
      "bio":user.aboutMe,
      "email":user.email,
      "userId":user.userId,
      "imageURL":user.profileImageLink!,
      
      
      ], completion: { (error) in
        if let error = error{
          print("updating the user failed: \(error.localizedDescription)")
        }else{
          print("post create ref number: \(ref?.documentID ?? "no id found")")
          DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document(ref!.documentID)
            .updateData(["dbReference":ref!.documentID], completion: { (error) in
              if let error = error {
                print("the error was \(error.localizedDescription)")
              }else {
                print("field updated")
              }
            })
        }
        
    })
  }
  static func postProductToDatabase(product:ProductModel,user:User){
    var ref: DocumentReference? = nil

    ref = firebaseDB.collection(FirebaseCollectionKeys.products).addDocument(data: ["productName" : product.productName,
                                                                                    "productDescription":product.productDescription,
                                                                                    
                                                            "userId": user.uid ,
                                                            "productImage":product.productImage,
                                                            "category":product.category],
      completion: { (error) in
                                                                                      if let error = error{
                                                                                        print("There was an error adding the product: \(error)")
                                                                                      }else{
                                                                                        print("product post created: \(ref?.documentID ?? "no id found")")
                                                                                        DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.products).document(ref!.documentID).updateData(["dbReference" : ref!.documentID], completion: { (error) in
                                                                                          if let error = error{
                                                                                            print("the error was: \(error)")
                                                                                          }else{
                                                                                            print("the product field was updated")
                                                                                          }
                                                                                        })
                                                                                        
                                                                                      }
    })
  }
  static public func postFeedTo(feed:FeedModel,user:User){
    var ref: DocumentReference? = nil
    ref = firebaseDB.collection(FirebaseCollectionKeys.feed).addDocument(data: ["feedId": feed.feedId,
                                                                                "productId": feed.productId!,
                                                                                "userId": user.uid,
                                                                                "caption": feed.caption,
                                                                                "imageUrl": feed.imageURL,
                                                        "userImage":user.photoURL?.absoluteString,
                                                        "userName": user.displayName], completion: { (error) in
      if let error = error{
        print("the error was: \(error)")
      }
      else{
        print("the product post created: \(ref?.documentID ?? "no id found")")
        DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.feed).document(ref!.documentID).updateData(["feedId":ref!.documentID], completion: { (error) in
          if let error = error{
            print("there was an error: \(error)")
          }
          else{
            print("feed was updated")
          }
        })
      }
    })
  }
}
