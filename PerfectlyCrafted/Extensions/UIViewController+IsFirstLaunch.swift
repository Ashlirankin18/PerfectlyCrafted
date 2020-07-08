//
//  UIViewController+IsFirstLaunch.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/18/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Indicates wether it is the first launch of the app.
    var isFirstLaunch: Bool {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "isFirstLaunch") != nil {
            return false
        } else {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
    }
}
