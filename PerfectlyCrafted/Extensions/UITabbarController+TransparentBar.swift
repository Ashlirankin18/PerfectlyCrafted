//
//  UITabbarController+TransparentBar.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/13/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UITabBarController {
    func transparentTabbarController () {
           tabBar.backgroundImage = UIImage()
           tabBar.shadowImage = UIImage()
           tabBar.isTranslucent = true
           view.backgroundColor = .clear
       }
}
