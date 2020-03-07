//
//  AddProductHeaderView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UIView` subclass which displays the header view.
final class AddProductHeaderView: UIView {
    
    /// Contains information required to configure the `AddProductHeaderView`.
    struct ViewModel {
        let image: UIImage
    }
    
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var addImageButton: UIButton!
    
    /// Single point of configuration of the `AddProductHeaderView`
    var viewModel: ViewModel? {
        didSet {
            postImageView.image = viewModel?.image
        }
    }
    
    /// Called when the header view is tapped.
    var addImageButtonTapped: (() -> Void)?
    
    @IBAction private func addImageButtonTapped(_ sender: UIButton) {
        addImageButtonTapped?()
    }
}
