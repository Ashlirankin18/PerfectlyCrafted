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
    
    private lazy var dotsViewController: DotViewController = UIStoryboard(name: "Pages", bundle: .main).instantiateViewController(identifier: "DotsViewController")
    
    private lazy var productDetailViewController = ProductDetailsViewController(product: product)
    
    private var product: Product
    
    private let persistenceController: PersistenceController
    
    init? (coder: NSCoder, product: Product, persistenceController: PersistenceController) {
        self.product = product
        self.persistenceController = persistenceController
        super.init(coder: coder)
        
        guard let images = product.images as? Set<Image>, !images.isEmpty else {
            return
        }
        let data = images.compactMap({ $0.imageData })
        let unwrappedImages = ImageUnWrapperHandler(imageDatas: data).unwrapImages()
        dotsViewController.images = unwrappedImages
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use the custom initializer provided.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        displayChildViewController(dotsViewController, in: productImageView)
        displayChildViewController(productDetailViewController, in: productDescriptionView)
    }
    
    private func configureNavigationItems() {
        let button = CircularButton.backButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        button.buttonTapped = { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    @IBAction private func editButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func deleteButtonPressed(_ sender: CircularButton) {
    }
    
    @IBAction private func shareButtonTapped(_ sender: CircularButton) {
    }
}
