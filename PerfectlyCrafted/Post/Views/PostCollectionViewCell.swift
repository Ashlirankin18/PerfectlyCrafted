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
    static let reuseIdentifier = String(describing: PostCollectionViewCell.self)
    /// Contains the information needed to configure the `PostCollectionViewCell`
    struct ViewModel {
        
        /// The image of the post.
        let postImage: UIImage?
        
        /// The title of the post.
        let title: String
        
        /// The date the post was created.
        let date: Date
    }
    
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    /// The single point of configuration of the `PostCollectionViewCell`
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return 
            }
            postImageView.isHidden = viewModel.postImage == nil ? true : false
            postImageView.image = viewModel.postImage
            captionLabel.text = viewModel.title
            dateLabel.text = DateFormatter.format(date: viewModel.date)
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        // 1
        let standardHeight = FeaturedLayoutConstants.Cell.standardHeight
        let featuredHeight = FeaturedLayoutConstants.Cell.featuredHeight
        
        // 2
        let delta = 1 - (
            (featuredHeight - frame.height) / (featuredHeight - standardHeight)
        )
        
        // 3
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        captionLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        dateLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
