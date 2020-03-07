//
//  CaptionView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/6/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class CaptionView: UIView {
    
    struct ViewModel {
        let caption: String
    }
    
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var moreOptionsButton: UIButton!
    
    var viewModel: ViewModel? {
        didSet {
            captionLabel.text = viewModel?.caption
        }
    }
    
    var editButtonTapped: (() -> Void)?
    
    @IBAction func moreOptionButtonTapped(_ sender: Any) {
        editButtonTapped?()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return viewFromNib()
    }
    
}
