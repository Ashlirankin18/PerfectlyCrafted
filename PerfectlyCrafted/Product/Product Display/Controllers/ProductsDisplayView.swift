//
//  ProductsDisplayController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct ProductsDisplayView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContect
    
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "entryDate", ascending: false)]) var products: FetchedResults<Product>
    
    var persistenceController: PersistenceController
    
    @State private var showingAddController: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products, id: \.id) { product in
                    NavigationLink(destination: DetailedView(product: product)) {
                        ProductView(product: product)
                    }
                }
            }
            .navigationBarTitle(Text("Products"))
            .navigationBarItems(trailing: RoundButton(imageName: "plus", action: {
                showingAddController.toggle()
            }))
            .sheet(isPresented: $showingAddController) {
                AddProductView(persistenceController: persistenceController)
            }
        }
    }
}
