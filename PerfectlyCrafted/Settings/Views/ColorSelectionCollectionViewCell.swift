//
//  ColorSelectionCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/22/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UICollectionViewCell` subclass which displays the various colors avalible.
final class ColorSelectionCollectionViewCell: UICollectionViewCell {
    
    /// Contains the information needed to configure the `ColorSelectionCollectionViewCell`.
    struct ViewModel {
        
        /// The color of the button.
        let color: UIColor
        
        /// Indicates wether the cell is selected.
        var isSelected: Bool
    }

    @IBOutlet private weak var checkmarkImageView: UIImageView!
    
    /// The single point of configuration of the `ColorSelectionCollectionViewCell`.
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
           backgroundColor = viewModel.color
            
            if viewModel.isSelected {
                checkmarkImageView.image = UIImage(systemName: "checkmark")
            } else {
                checkmarkImageView.image = nil
            }
        }
    }
}
