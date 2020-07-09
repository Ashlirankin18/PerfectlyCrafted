//
//  PostShareView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/19/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UIView` subclass displays the shared post.
final class PostShareView: UIView {
    
    ///
    struct ViewModel {
        
        /// The post image.
        let image: UIImage
        
        /// The post title.
        let postTitle: String
        
        /// The post date.
        let date: Date
        
        /// The post description.
        let description: String
    }
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var postDescriptionLabel: UILabel!
    
    /// Contains the information needed to configure the `PostShareView`
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            postImageView.image = viewModel.image
            postTitleLabel.text = viewModel.postTitle
            dateLabel.text = DateFormatter.format(date: viewModel.date)
            postDescriptionLabel.text = viewModel.description
        }
    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
        super.awakeAfter(using: coder)
        return viewFromNib()
    }
}
