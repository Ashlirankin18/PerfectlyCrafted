//
//  ProductDetailsViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class ProductDetailsViewController: UIViewController {

    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productExperienceTextView: UITextView!
    @IBOutlet private weak var isFinishedLabel: UILabel!
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: "ProductDetailsViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        if let productDescription = product.productDescription {
            productDescriptionLabel.text = productDescription
        } else {
          productDescriptionLabel.text = "productDescription"
        }
        if let productExperience = product.experience {
            productExperienceTextView.text = productExperience
        } else {
             productExperienceTextView.text = "productExperience"
        }
    }
}
