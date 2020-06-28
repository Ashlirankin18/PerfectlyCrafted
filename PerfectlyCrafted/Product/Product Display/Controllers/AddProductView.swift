//
//  AddProductView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct AddProductView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    private let persistenceController = PersistenceController(modelName: "PerfectlyCrafted")
    
    var product: Product
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let productsDetailController = UIStoryboard(name: "ProductDetail", bundle: Bundle.main).instantiateViewController(identifier: "ProductDetailViewController", creator: { coder in
            return ProductDetailViewController(coder: coder, product: product, persistenceController: self.persistenceController)
        })
        return productsDetailController
    }
}
