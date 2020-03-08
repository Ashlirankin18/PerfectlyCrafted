//
//  PostCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/6/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UICollectionViewCell` subclass which displays a post
final class PostCollectionViewCell: UICollectionViewCell {
    
    /// Contains the information needed to configure the `PostCollectionViewCell`
    struct ViewModel {
        
        /// The image of the post.
        let postImage: UIImage?
        
        let caption: String
        
        let description: String
    }
    
    @IBOutlet private weak var moreOptionsButton: UIButton!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    /// The single point of configuration of the `PostCollectionViewCell`
    var viewModel: ViewModel? {
        didSet {
            postImageView.image = viewModel?.postImage
            captionLabel.text = viewModel?.caption
            descriptionLabel.text = viewModel?.description
        }
    }
    
    var editButtonTapped: (() -> Void)?
    
    @IBAction func moreOptionButtonTapped(_ sender: Any) {
        editButtonTapped?()
    }
}
