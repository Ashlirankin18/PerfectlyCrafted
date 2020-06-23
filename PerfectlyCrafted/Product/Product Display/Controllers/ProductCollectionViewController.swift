//
//  ProductCollectionViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

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
    
    private let persistenceController: PersistenceController
    
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
    
    private var fetchResultsController: NSFetchedResultsController<Product>?
    
    init?(coder: NSCoder, persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.transparentNavigationController()
        navigationItem.rightBarButtonItem = addPostBarButtonItem
        configureFetchResultsController()
        configureEmptyStateController()
    }
    
    private func configureEmptyStateController() {
        emptyStateViewController.addEntryButtonTapped = { [weak self] in
            guard let self = self else {
                return
            }
            self.presentAddViewController()
        }
    }
    
    private func configureFetchResultsController() {
        let sortDescriptor = NSSortDescriptor(key: "entryDate", ascending: false)
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistenceController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController?.delegate = self
        
        do {
            try fetchResultsController?.performFetch()
            if let products = fetchResultsController?.fetchedObjects {
                self.products = products
            }
        } catch {
            print(error)
        }
    }
    
    private func configureCellWithProduct(cell: ProductCollectionViewCell, product: Product) {
        guard let images = product.images as? Set<Image>, !images.isEmpty, let image = images.first, let data = image.imageData  else {
            cell.viewModel = ProductCollectionViewCell.ViewModel(name: product.name ?? "no name", isCompleted: product.isfinished, productImage: nil)
            return
        }
        DispatchQueue.main.async {
            guard let productImage = UIImage(data: data) else {
                cell.viewModel = ProductCollectionViewCell.ViewModel(name: product.name ?? "no name", isCompleted: product.isfinished, productImage: nil)
                return
            }
            cell.viewModel = ProductCollectionViewCell.ViewModel(name: product.name ?? "no name", isCompleted: product.isfinished, productImage: productImage)
        }
    }
    
    private func presentAddViewController() {
        let addPostViewController = UIStoryboard(name: "AddProduct", bundle: Bundle.main).instantiateViewController(identifier: "AddProductViewController") { coder in
            return AddProductViewController(coder: coder, persistenceController: self.persistenceController, productId: UUID())
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
        let product = products[indexPath.row]
        
        configureCellWithProduct(cell: cell, product: product)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let detailledController = UIStoryboard(name: "ProductDetail", bundle: Bundle.main).instantiateViewController(identifier: "ProductDetailViewController", creator: { coder in
            return ProductDetailViewController(coder: coder, product: product)
        })
        let detailledNavigationController = UINavigationController(rootViewController: detailledController)
        detailledNavigationController.modalPresentationStyle = .fullScreen
        present(detailledNavigationController, animated: true)
    }
}

extension ProductCollectionViewController: NSFetchedResultsControllerDelegate {
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .update:
            guard let indexPath = newIndexPath else {
                return
            }
            collectionView.reloadItems(at: [indexPath])
        case .insert, .move, .delete:
            guard let products = controller.fetchedObjects as? [Product] else {
                return
            }
            self.products = products
        default:
            print("An unknown case was not handled.")
        }
    }
}
