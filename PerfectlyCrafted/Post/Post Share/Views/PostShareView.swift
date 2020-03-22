//
//  PostShareView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/19/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class PostShareView: UIView {
    
    struct ViewModel {
        let image: UIImage
        let postTitle: String
        let date: Date
    }
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            postImageView.image = viewModel.image
            postTitleLabel.text = viewModel.postTitle
            dateLabel.text = DateFormatter.format(date: viewModel.date)
        }
    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
        super.awakeAfter(using: coder)
        return viewFromNib()
    }
}
