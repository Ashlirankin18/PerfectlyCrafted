//
//  UserSession.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseAuth

final class UserSession {

    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func createAccountUsingPhoneAuth(phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void ) {
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
