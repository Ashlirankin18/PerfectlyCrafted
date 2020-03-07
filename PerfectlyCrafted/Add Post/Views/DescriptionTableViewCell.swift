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
}
class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    weak var delegate : DescriptionTableViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionTextView.delegate = self
    }
    

}

extension DescriptionTableViewCell: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let deletate = delegate {
            deletate.updateHeightOfRow(self, textView.bounds.size)
        }
    }
}


