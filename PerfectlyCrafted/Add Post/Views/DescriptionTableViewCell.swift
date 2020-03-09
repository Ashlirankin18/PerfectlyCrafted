//
//  TableViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
protocol DescriptionTableViewCellDelegate: AnyObject {
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize)
    
    func textViewDidEndEditing(_ cell: DescriptionTableViewCell, _ text: String)
}

final class DescriptionTableViewCell: UITableViewCell {
    
    /// Contains the information needed to configure the `DescriptionTableViewCell`.
    struct ViewModel {
        
        let placeholder: String
    }
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    /// <#Description#>
    weak var delegate : DescriptionTableViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionTextView.delegate = self
    }
    
    /// Single point of configuration of `DescriptionTableViewCell`.
    var viewModel: ViewModel? {
        didSet {
            descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
            descriptionTextView.text = viewModel?.placeholder
            descriptionTextView.textColor = .lightGray
        }
    }
    
    @objc private func tapDone(sender: Any) {
        delegate?.textViewDidEndEditing(self, descriptionTextView.text)
        endEditing(true)
    }
}


extension DescriptionTableViewCell: UITextViewDelegate {
    
    //MARK: - UITextViewDelegate
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let deletate = delegate {
            deletate.updateHeightOfRow(self, textView.bounds.size)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !descriptionTextView.text.isEmpty {
            descriptionTextView.textColor = .black
            descriptionTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textViewDidEndEditing(self, textView.text)
        endEditing(true)
    }
}
