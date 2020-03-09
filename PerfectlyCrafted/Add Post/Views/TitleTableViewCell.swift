//
//  TitleTableViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which displays a textfield 
final class TitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleTextField: UITextField!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleTextField.delegate = self
    }
    
    /// Called when the editing has ended
    var textFieldDidEndEditing: ((UITextField) -> Void)?
}
extension TitleTableViewCell: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.resignFirstResponder()
        textFieldDidEndEditing?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
