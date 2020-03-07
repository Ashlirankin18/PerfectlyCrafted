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
    
    struct ViewModel {
        let postImage: UIImage
        let captionViewModel: CaptionView.ViewModel
    }
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionView: CaptionView!
    
    var viewModel: ViewModel? {
        didSet {
          postImageView.image = viewModel?.postImage
          captionView.viewModel = viewModel?.captionViewModel
        }
    }
}
