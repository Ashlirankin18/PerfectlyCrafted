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
        
        /// The caption of the image
        let captionViewModel: CaptionView.ViewModel
    }
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionView: CaptionView!
    
    /// The single point of configuration of the `PostCollectionViewCell`
    var viewModel: ViewModel? {
        didSet {
          postImageView.image = viewModel?.postImage
          captionView.viewModel = viewModel?.captionViewModel
        }
    }
}
