//
//  ProductDetailViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    @IBOutlet private weak var productImageView: UIView!
    @IBOutlet private weak var productDescriptionView: UIView!
    
    private lazy var imagePageController = UIStoryboard(name: "Pages", bundle: Bundle.main).instantiateViewController(identifier: "DotsViewController")
   
    private lazy var productDetailViewController = ProductDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayChildViewController(imagePageController, in: productImageView)
        displayChildViewController(productDetailViewController, in: productDescriptionView)
    }

    @IBAction private func editButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func deleteButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func shareButtonTapped(_ sender: CircularButton) {
    }
}
