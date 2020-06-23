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
   
    private lazy var productDetailViewController = ProductDetailsViewController(product: product!)
    
    private var product: Product?
    
    init? (coder: NSCoder, product: Product) {
        self.product = product
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        displayChildViewController(imagePageController, in: productImageView)
        displayChildViewController(productDetailViewController!, in: productDescriptionView)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    @IBAction private func editButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func deleteButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func shareButtonTapped(_ sender: CircularButton) {
    }
}
