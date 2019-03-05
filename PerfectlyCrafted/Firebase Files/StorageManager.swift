//
//  StorageManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseAuth


protocol StorageManagerDelegate: AnyObject {
  func didFetchImage(_ storageManager: StorageManager, imageURL: URL)
}

final class StorageManager {
  weak var delegate: StorageManagerDelegate?
  
  // reference to the firebsase storage app
  private let storageRef: StorageReference = {
    let storage = Storage.storage()
    return storage.reference()
  }()
  
  public func postImage(withData data: Data) {
    if let userId = Auth.auth().currentUser?.uid {
      let imagesRef = storageRef.child(StorageKeys.ImagesKey)
      let newImageRef = imagesRef.child("\(userId).jpg")
      let metadata = StorageMetadata()
      metadata.contentType = "image/jpeg"
      let uploadTask = newImageRef.putData(data, metadata: metadata) { (metadata, error) in
        guard let metadata = metadata else {
          print("error uploading data")
          return
        }
        let _ = metadata.size // other properties, content-type
        newImageRef.downloadURL(completion: { (url, error) in
          if let error = error {
            print("downloadURL error: \(error)")
          } else if let url = url {
            // can be attached to a document in the a firestore collection as needed
            print("downloadURL: \(url)")
            
            self.delegate?.didFetchImage(self, imageURL: url)
          }
        })
      }
      // observe states on uploadTask
      uploadTask.observe(.failure) { (storageTaskSnapshot) in
        print("failure...")
      }
      uploadTask.observe(.pause) { (storageTaskSnapshot) in
        print("pause...")
      }
      uploadTask.observe(.progress) { (storageTaskSnapshot) in
        print("progress...")
      }
      uploadTask.observe(.resume) { (storageTaskSnapshot) in
        print("resume...")
      }
      uploadTask.observe(.success) { (storageTaskSnapshot) in
        print("success...")
      }
    }else{
      print("no auth user")
    }
    
  }
  
}
