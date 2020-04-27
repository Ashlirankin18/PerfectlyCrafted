//
//  AppDelegate.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var persistenceController = PersistenceController(modelName: "PerfectlyCrafted")
    private lazy var userSession = UserSession()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        var rootViewController: UIViewController
        
        if userSession.getCurrentUser() != nil {
            rootViewController = PerfectlyCraftedTabBarViewController(persistenceController: persistenceController)
        } else {
            rootViewController = LoginFlowViewController(nibName: "LoginFlowViewController", bundle: nil)
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
