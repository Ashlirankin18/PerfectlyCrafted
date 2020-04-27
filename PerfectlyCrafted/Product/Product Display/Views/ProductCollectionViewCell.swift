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
          let productImage: UIImage
      }
      
      @IBOutlet private weak var productNameLabel: UILabel!
      @IBOutlet private weak var completedLabel: UILabel!
      @IBOutlet private weak var productImageView: UIImageView!
      
      var viewModel: ViewModel? {
          didSet {
              productNameLabel.text = viewModel?.name
              let completed = !(viewModel?.isCompleted ?? false) ? "Still in use": "Completed"
              completedLabel.text = completed
              productImageView.image = viewModel?.productImage
          }
      }
}
