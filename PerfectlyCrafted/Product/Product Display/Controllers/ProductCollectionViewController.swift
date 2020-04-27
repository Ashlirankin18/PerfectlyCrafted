//
//  ProductCollectionViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class ProductCollectionViewController: UICollectionViewController {
    
    private lazy var addPostBarButtonItem: UIBarButtonItem = {
        let button = CircularButton.addButton
        button.buttonTapped = { [weak self] button in
            
            guard let self = self else {
                return
            }
            self.presentAddViewController()
        }
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var userSession = UserSession()
    
    private lazy var databaseManager = DatabaseManager(userSession: userSession)
    
    private lazy var emptyStateViewController = EmptyStateViewController(primaryText: "Add Product", secondaryText: "Tap the button below to create add a product.")
 
    private var products: [Product] = [Product]() {
        didSet {
            if products.isEmpty {
                displayChildViewController(emptyStateViewController, in: view)
            } else {
                remove(asChildViewController: emptyStateViewController)
                collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.transparentNavigationController()
        navigationItem.rightBarButtonItem = addPostBarButtonItem
        configureEmptyStateController()
        products = databaseManager.products
    }
    
    private func configureEmptyStateController() {
        emptyStateViewController.addEntryButtonTapped = { [weak self] in
            guard let self = self else {
                return
            }
            self.presentAddViewController()
        }
    }
    
    private func presentAddViewController () {
        let addPostViewController = UIStoryboard(name: "AddProduct", bundle: Bundle.main).instantiateViewController(identifier: "AddProductViewController") { coder in
            return AddProductViewController(coder: coder, databaseManager: self.databaseManager)
        }
        let addProductNavigationController = UINavigationController(rootViewController: addPostViewController)
        addProductNavigationController.modalPresentationStyle = .fullScreen
        self.show(addProductNavigationController, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
