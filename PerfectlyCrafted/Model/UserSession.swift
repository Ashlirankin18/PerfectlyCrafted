//
//  CurrentUser.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol UserSessionAccountCreationDelegate:AnyObject {
  func didReceiveError(_ userSession: UserSession, error:Error)
  func didCreateAccount(_ userSession:UserSession,user:User)
}
protocol UserSessionSignOutDelegate:AnyObject{
  func didReceiveSignOutError(_ userSession:UserSession,error:Error)
  func didSignOutUser(_userSession:UserSession)
}
protocol UserSessionSignInExistingUserDelegate:AnyObject {
  func didReceiveSignInError(_ userSession: UserSession,error:Error)
  func didSignInUser(_ userSession: UserSession, user: User)
}

class UserSession {
  weak var userSessionAccountdelegate: UserSessionAccountCreationDelegate?
  weak var userSessionSignOutDelegate: UserSessionSignOutDelegate?
  weak var userSignInDelegate: UserSessionSignInExistingUserDelegate?
  

 public func createUser(email:String,password:String){
    Auth.auth().createUser(withEmail: email, password: password) { (authDataResults, error) in
      if let error = error{
        self.userSessionAccountdelegate?.didReceiveError(self, error: error)
      }
      else if let authDataResults = authDataResults{
        self.userSessionAccountdelegate?.didCreateAccount(self, user: authDataResults.user)
      }
    }
  }
  public func getCurrentUser() -> User?{
    return Auth.auth().currentUser
  }
  public func signOut(){
    do{
      try Auth.auth().signOut()
      userSessionSignOutDelegate?.didSignOutUser(_userSession: self)
    }catch{
      userSessionSignOutDelegate?.didReceiveSignOutError(self, error: error)
    }
  }
  public func signInExistingUser(email:String,password:String){
    Auth.auth().signIn(withEmail: email, password: password) { (results, error) in
      if let error = error{
        self.userSignInDelegate?.didReceiveSignInError(self, error: error)
      }
      else if let results = results{
        self.userSignInDelegate?.didSignInUser(self, user: results.user)
      }
    }
  }
}
