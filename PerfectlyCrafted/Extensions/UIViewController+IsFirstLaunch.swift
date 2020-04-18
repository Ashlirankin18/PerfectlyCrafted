//
//  UIViewController+IsFirstLaunch.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/18/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var isFirstLaunch: Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}
