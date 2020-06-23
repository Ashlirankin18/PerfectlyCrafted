//
//  DatabaseManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//final class DatabaseManager {
//    
//    private let userSession: UserSession
//    
//    var products = [Product]()
//    
//    lazy var newDocumentId: String = self.firebaseDB.collection(DatabaseCollectionKeys.products).document().documentID
//    
//    init(userSession: UserSession) {
//        self.userSession = userSession
//        retrieveItems()
//    }
//    
//    let firebaseDB: Firestore = {
//        let db = Firestore.firestore()
//        let settings = db.settings
//        db.settings = settings
//        return db
//    }()
//    
//    func postProductToDatabase(product: Product) -> String {
//        guard let user = userSession.getCurrentUser() else {
//            return ""
//        }
//        var ref: DocumentReference?
//        ref = firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products)
//            .addDocument(data: [
////                "name": product.name,
////                "category": product.category,
////                "documentId": product.documentId,
////                "imageURLS": product.imageURLS,
////                "experience`": product.experience,
////                "isFinished": product.isFinished
//                ], completion: { (error) in
//                    if let error = error {
//                        print("posting product failed with error: \(error)")
//                    } else {
//                        self.firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products)
//                            .document(ref!.documentID)
//                            .updateData(["documentId": ref!.documentID], completion: { (error) in
//                                if let error = error {
//                                    print("error updating field: \(error)")
//                                }
//                            })
//                    }
//            })
//        return ref?.documentID ?? ""
//    }
//    
//    func updateProductOnDatabase(documentId: String, name: String? = nil, category: String? = nil, imageURLS: [String]? = nil, experience: String? = nil, isFinished: Bool? = nil) {
//        guard let user = userSession.getCurrentUser() else {
//            return
//        }
//        
//        if let name = name {
//            firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).updateData(["name": name])
//        }
//        if let category = category {
//            firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).updateData(["category": category])
//        }
//        
//        if let imageURLS = imageURLS {
//            firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).updateData(["imageURLS": imageURLS])
//        }
//        
//        if let experience = experience {
//            firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).updateData(["experience": experience])
//        }
//        
//        if let isFinished = isFinished {
//            firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).updateData(["isFinished": isFinished])
//        }
//    }
//    
//     func retrieveItems() {
//        guard let user = userSession.getCurrentUser() else {
//            return
//        }
//        firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).getDocuments { (snapshot, error) in
//            if let snapshot = snapshot {
////                for doc in snapshot.documents {
////                    let product = Product(dict: doc.data())
////                    self.products.append(product)
//                }
//            }
//            if let error = error {
//                print(error)
//            }
//        }
//    }
//    
//     func removeProductFromDatabase(documentId: String) {
//        guard let user = userSession.getCurrentUser(), !documentId.isEmpty else {
//            return
//        }
//        firebaseDB.collection(DatabaseCollectionKeys.users).document(user.uid).collection(DatabaseCollectionKeys.products).document(documentId).delete { (error) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
