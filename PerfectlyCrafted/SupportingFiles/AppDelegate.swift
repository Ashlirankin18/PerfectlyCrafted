//
//  AppDelegate.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var persistenceController = PersistenceController(modelName: "PerfectlyCrafted")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = PerfectlyCraftedTabBarViewController(persistenceController: persistenceController)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
