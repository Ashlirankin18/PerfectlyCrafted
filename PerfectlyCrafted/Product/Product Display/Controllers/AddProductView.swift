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
    
    /// The persistence controller.
    var persistenceController: PersistenceController
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let addProductController = UIStoryboard(name: "AddProduct", bundle: Bundle.main).instantiateViewController(identifier: "AddProductViewController", creator: { coder in
            return AddProductViewController(coder: coder, persistenceController: persistenceController, productId: UUID())
        })
        let addNavigationController = UINavigationController(rootViewController: addProductController)
        return addNavigationController
    }
}
