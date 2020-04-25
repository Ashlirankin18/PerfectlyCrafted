//
//  DatabaseManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DatabaseManager {
    
    private init() {}
    
    static let firebaseDB: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        db.settings = settings
        return db
    }()
    
    static func postProductToDatabase(product: Product) {
        var ref: DocumentReference? = nil
        ref = firebaseDB.collection(DatabaseCollectionKeys.users).addDocument(data: [
            "name"    : product.name,
            "category"  : product.category,
            "documentId"  : product.documentId,
            "imageURLS"    : product.imageURLS,
            "experience`": product.experience,
            "isFinished": product.isFinished,
            "purchaseLocation": product.purchaseLocation
            ], completion: { (error) in
                if let error = error {
                    print("posing race failed with error: \(error)")
                } else {
                    print("post created at ref: \(ref?.documentID ?? "no doc id")")
                    
                    DatabaseManager.firebaseDB.collection(DatabaseCollectionKeys.products)
                        .document(ref!.documentID)
                        .updateData(["documentId": ref!.documentID], completion: { (error) in
                            if let error = error {
                                print("error updating field: \(error)")
                            } else {
                                print("field updated")
                            }
                        })
                }
        })
    }
    
    static func retrieveItems() {
        firebaseDB.collection(DatabaseCollectionKeys.products)
    }
}
