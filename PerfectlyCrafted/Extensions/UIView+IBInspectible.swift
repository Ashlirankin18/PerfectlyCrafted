//
//  UIView+IBInspectible.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/6/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// A `UIView` extension that adds layer properties as `@IBInspectable` properties of the view itself so that they can be set within Interface Builder.
extension UIView {
    
    /// The receiver’s `layer` corner radius.
    ///
    /// - SeeAlso:
    /// [CALayer.cornerRadius](https://developer.apple.com/documentation/quartzcore/calayer/1410818-cornerradius)
    @IBInspectable public var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// The receiver’s `layer` border width.
    ///
    /// - SeeAlso:
    /// [CALayer.borderWidth](https://developer.apple.com/documentation/quartzcore/calayer/1410917-borderwidth)
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Sets the `UIView` to be a circle.
    @IBInspectable public var isCircle: Bool {
        get {
            return layer.cornerRadius * 2 == frame.width
        } set { //swiftlint:disable:this unused_setter_value
            layer.cornerRadius = frame.width / 2
        }
    }
    
    /// The receiver’s `layer` border color.
    ///
    /// - SeeAlso:
    /// [CALayer.borderColor](https://developer.apple.com/documentation/quartzcore/calayer/1410903-bordercolor)
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Whether the receiver’s `layer` masks to bounds.
    ///
    /// - SeeAlso:
    /// [CALayer.masksToBounds](https://developer.apple.com/documentation/quartzcore/calayer/1410896-maskstobounds)
    @IBInspectable public var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /// The receiver’s `layer` shadow color.
    ///
    /// - SeeAlso:
    /// [CALayer.shadowColor](https://developer.apple.com/documentation/quartzcore/calayer/1410829-shadowcolor)
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// The receiver’s `layer` shadow opacity.
    ///
    /// - SeeAlso:
    /// [CALayer.shadowOpacity](https://developer.apple.com/documentation/quartzcore/calayer/1410751-shadowopacity)
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// The receiver’s `layer` shadow offset.
    ///
    /// - SeeAlso:
    /// [CALayer.shadowOffset](https://developer.apple.com/documentation/quartzcore/calayer/1410970-shadowoffset)
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// The receiver’s `layer` shadow radius.
    ///
    /// - SeeAlso:
    /// [CALayer.shadowOffset](https://developer.apple.com/documentation/quartzcore/calayer/1410970-shadowoffset)
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}
