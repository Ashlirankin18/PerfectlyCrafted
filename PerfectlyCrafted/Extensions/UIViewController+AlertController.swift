//
//  UIViewController+AlertController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertController(message: String, actionTitle: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.view.tintColor = .black
        present(alertController, animated: true)
    }
    
    /// Presents an Alert Controller to promt the user.
    /// - Parameters:
    ///   - message: The message to be displayed to the user.
    ///   - actionTitle: The title of the destructive button.
    ///   - completeion: This is call after the user taps the destructive action button.
    func presentAlertControllerForDestructiveAction(message: String, descructiveTitle: String, nonDestructiveTitle: String, completeion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: descructiveTitle, style: .destructive, handler: { _  in
            completeion()
        })
        let cancelAction = UIAlertAction(title: nonDestructiveTitle, style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = .black
        present(alertController, animated: true)
    }
}
