//
//  SFSymbols.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/5/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var settings: UIImage {
        return UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var add: UIImage {
        return UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var cancel: UIImage {
        return UIImage(systemName: "multiply", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var edit: UIImage {
        return UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var delete: UIImage {
        return UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var back: UIImage {
        return UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
    
    static var confirm: UIImage {
        return UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)) ?? UIImage()
    }
}
