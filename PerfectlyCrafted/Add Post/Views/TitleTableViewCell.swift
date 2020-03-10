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
    struct ViewModel {
        let title: String
    }
    
    @IBOutlet private weak var titleTextField: UITextField!
    
    var viewModel: ViewModel? {
        didSet {
            titleTextField.text = viewModel?.title
        }
    }
    
    /// Called when the editing has ended
    var textFieldDidEndEditing: ((UITextField) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleTextField.delegate = self
    }
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
