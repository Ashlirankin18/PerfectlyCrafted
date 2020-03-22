//
//  AssetColors.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/22/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

enum AssetsColor: Int, CaseIterable {
  
    case coolGreen
    case coolBlue
    case mintGreen
    case purple
    case pink
    case pastelBlue
    case pastelGreen
    case pastelPink
    case pastelPurple
    case pastelYellow
    
    enum Keys {
        static let selectedColor = "selectedColor"
    }
    
    static var current: AssetsColor {
        let storedColor = UserDefaults.standard.integer(forKey: Keys.selectedColor)
        return AssetsColor(rawValue: storedColor) ?? AssetsColor.coolBlue
    }
    
    static var allCases: [AssetsColor] {
        return [.coolGreen, .coolBlue, .mintGreen, .purple, .pink, .pastelBlue, .pastelPink, .pastelGreen, .pastelPurple, .pastelYellow ]
    }
    
    var color: UIColor {
        switch self {
        case .coolGreen:
            return UIColor(named: "coolGreen") ?? UIColor.black
        case .coolBlue:
            return UIColor(named: "coolBlue") ?? UIColor.black
        case .mintGreen:
            return UIColor(named: "mintGreen") ?? UIColor.black
        case .purple:
            return UIColor(named: "purple") ?? UIColor.black
        case .pink:
            return UIColor(named: "pink") ?? UIColor.black
        case .pastelBlue:
            return UIColor(named: "pastelBlue") ?? UIColor.black
        case .pastelGreen:
            return UIColor(named: "pastelGreen") ?? UIColor.black
        case .pastelPink:
            return UIColor(named: "pastelPink") ?? UIColor.black
        case .pastelPurple:
            return UIColor(named: "pastelPurple") ?? UIColor.black
        case .pastelYellow:
            return UIColor(named: "pastelYellow") ?? UIColor.black
        }
    }
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedColor)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = color
    }
}
