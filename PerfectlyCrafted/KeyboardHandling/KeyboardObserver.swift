//
//  KeyboardObserver.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/23/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class KeyboardObserver {
    
    private let raisedViews: [UIView]
    
    init (raisedViews: [UIView]) {
        self.raisedViews = raisedViews
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNofications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func willShowKeyboard(notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                print("userinfo is nil")
                return
        }
        raisedViews.forEach({
            $0.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
            $0.isHidden = true
        })
    }
    
    @objc private func willHideKeyboard(notification: Notification) {
        raisedViews.forEach({
            $0.transform = CGAffineTransform.identity
            $0.isHidden = false
        })
    }
}
