//
//  ProductDescriptionView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 7/9/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct ProductDescriptionView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(product.name?.capitalized ?? "")
                .font(.custom("Avenir Next Bold", size: 30.0))
                .multilineTextAlignment(.center)
            HStack {
                VStack(alignment: .leading) {
                    Text("Product Description")
                        .font(.custom("Avenir Next Bold", size: 19.0))
                    Spacer(minLength: 20)
                    Text(product.productDescription ?? "")
                        .font(.custom("Avenir Next Medium", size: 17.0))
                }
                Spacer()
            }
            Text("I thought...")
                .font(.custom("Avenir Next Bold", size: 17.0))
            Text(product.experience ?? "")
                .font(.custom("Avenir Next Medium", size: 17.0))
            Text("ProductCategory")
                .font(.custom("Avenir Next Bold", size: 17.0))
            Text(product.category ?? "")
                .font(.custom("Avenir Next Medium", size: 17.0))
            Text("IsComplete")
                .font(.custom("Avenir Next Bold", size: 17.0))
            if product.isfinished {
                Text("Complete")
                    .font(.custom("Avenir Next Medium", size: 17.0))
            } else {
                Text("Still In Use")
                    .font(.custom("Avenir Next Medium", size: 17.0))
            }
        }
    }
}
