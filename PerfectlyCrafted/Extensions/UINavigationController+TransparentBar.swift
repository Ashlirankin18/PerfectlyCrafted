//
//  UINavigationController+TransparentBar.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/13/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UINavigationController {
    func transparentNavigationController () {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
    }
}
