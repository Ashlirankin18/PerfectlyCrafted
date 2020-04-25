//
//  UserSession.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//


import Foundation
import FirebaseAuth

protocol UserSessionAccountCreationDelegate: AnyObject {
    func didCreateAccount(_ userSession: UserSession, user: User)
    func didRecieveErrorCreatingAccount(_ userSession: UserSession, error: Error)
}

protocol UserSessionSignOutDelegate: AnyObject {
    func didRecieveSignOutError(_ usersession: UserSession, error: Error)
    func didSignOutUser(_ usersession: UserSession)
}

protocol UserSessionSignInDelegate: AnyObject {
    func didRecieveSignInError(_ usersession: UserSession, error: Error)
    func didSignInExistingUser(_ usersession: UserSession, user: User)
}

final class UserSession {
    weak var userSessionAccountDelegate: UserSessionAccountCreationDelegate?
    weak var usersessionSignOutDelegate: UserSessionSignOutDelegate?
    weak var usersessionSignInDelegate: UserSessionSignInDelegate?
    
    // creates an authenticated user
    // on completion of creating authenticated user add the user to the firestore database
    func createNewAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.userSessionAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
            } else if let authDataResult = authDataResult {
                self.userSessionAccountDelegate?.didCreateAccount(self, user: authDataResult.user)
                guard let username = authDataResult.user.email?.components(separatedBy: "@").first else {
                    print("no email entered")
                    return
                }
                // add user to database
                // use the user.uid as the document id for ease of use when updating / querying current user
                DatabaseManager.firebaseDB.collection(DatabaseCollectionKeys.users)
                    .document(authDataResult.user.uid.description)
                    .setData(["userId"      : authDataResult.user.uid,
                              "email"       : authDataResult.user.email ?? "",
                              "displayName" : authDataResult.user.displayName ?? "",
                              "imageURL"    : authDataResult.user.photoURL ?? "",
                              "username"    : username
                        ], completion: { (error) in
                            if let error = error {
                                print("error adding authenticated user to the database: \(error)")
                            }
                    })
            }
        }
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func signInExistingUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.usersessionSignInDelegate?.didRecieveSignInError(self, error: error)
            } else if let authDataResult = authDataResult {
                self.usersessionSignInDelegate?.didSignInExistingUser(self, user: authDataResult.user)
            }
        }
    }
    
    func signOut() {
        guard let _ = getCurrentUser() else {
            print("no logged user")
            return
        }
        do {
            try Auth.auth().signOut()
            usersessionSignOutDelegate?.didSignOutUser(self)
        } catch {
            usersessionSignOutDelegate?.didRecieveSignOutError(self, error: error)
        }
    }
    
    func updateUser(displayName: String?, photoURL: URL?) {
        guard let user = getCurrentUser() else {
            print("no logged user")
            return
        }
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        request.photoURL = photoURL
        request.commitChanges { (error) in
            if let error = error {
                print("error: \(error)")
            } else {
                // update database user as well
                guard let photoURL = photoURL else {
                    print("no photoURL")
                    return
                }
                DatabaseManager.firebaseDB
                    .collection(DatabaseCollectionKeys.users)
                    .document(user.uid) // making the user document id the same as the auth userId makes it easy to update the user doc
                    .updateData(["imageURL": photoURL.absoluteString], completion: { (error) in
                        guard let error = error else {
                            print("successfully ")
                            return
                        }
                        print("updating photo url error: \(error.localizedDescription)")
                    })
            }
        }
    }
    
    func createAccountUsingPhoneAuth(phoneNumber: String, completion: @escaping (Result<String,Error>) -> Void ) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let verficationId = verificationID {
               UserDefaults.standard.set(verficationId, forKey: "authVerificationID")
                completion(.success(verficationId))
            }
        }
    }
    
    func signInUserWithVerificationCode(verificationCode: String, verificationId: String) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print(error)
            }
            
            if let result = result {
                print(result.user)
            }
        }
    }
}
