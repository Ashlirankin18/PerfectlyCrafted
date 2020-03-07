//
//  TitleTableViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleTextField: UITextField!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleTextField.delegate = self
    }
    
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
