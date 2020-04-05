//
//  CircularButton.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/5/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class CircularButton: UIButton {
    enum DesignConstants {
        static let circularButtonFrame: CGRect = CGRect(x: .zero, y: .zero, width: 36.0, height: 36.0)
        static let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium)
    }
    
    var buttonTapped: ((UIButton) -> Void)?
    
    init(frame: CGRect = DesignConstants.circularButtonFrame, image: UIImage, backgroundColor: UIColor = .white, tintColor: UIColor = .black) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.setImage(image, for: .normal)
        imageView?.tintColor = tintColor
        addCornerRadius()
        configureShadow()
        
        addTarget(self, action: #selector(circularButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = backgroundColor
        imageView?.tintColor = tintColor
        addCornerRadius()
        configureShadow()
        
        addTarget(self, action: #selector(circularButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addCornerRadius() {
        cornerRadius = frame.height / 2
    }
    
    private func configureShadow() {
        clipsToBounds = true
        layer.masksToBounds = false
        shadowColor = UIColor.black.withAlphaComponent(0.15)
        shadowOffset = CGSize(width: 0, height: 2)
        shadowOpacity = 1.0
        shadowRadius = 0.5
    }
    
    @objc func circularButtonTapped(_ sender: UIButton) {
        buttonTapped?(sender)
    }
}

extension CircularButton {
    
    static var settingsButton: CircularButton = .init(image: .settings)
    
    static var addButton: CircularButton = .init(image: .add)
    
    static var editButton: CircularButton = .init(image: .edit)
    
    static var backButton: CircularButton = .init(image: .back)
}
