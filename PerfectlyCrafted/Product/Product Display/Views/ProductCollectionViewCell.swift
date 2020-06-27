//
//  ProductCollectionViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        let name: String
        let isCompleted: Bool
        let productImage: UIImage?
    }
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var completedLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            productNameLabel.text = viewModel.name
            let completed = !viewModel.isCompleted ? "Still in use": "Completed"
            completedLabel.text = completed
            if viewModel.productImage == nil {
                productImageView.backgroundColor = .lightGray
            } else {
                productImageView.image = viewModel.productImage
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
}
