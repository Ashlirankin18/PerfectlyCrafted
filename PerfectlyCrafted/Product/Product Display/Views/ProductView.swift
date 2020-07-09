//
//  ProductView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 7/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct ProductView: View {
    
    var product: Product
    
    var body: some View {
        HStack {
            SwiftUI.Image(uiImage: unwrapImages())
                .resizable(capInsets:/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/, resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(6)
            VStack(alignment: .leading) {
                Text(product.name ?? "no name found")
                    .font(.custom("Avenir Next", size: 18.0)).bold()
                Text(product.category ?? "no category found")
                    .font(.custom("Avenir Next Regular", size: 14.0))
            }
        }
    }
    
    private func unwrapImages() -> UIImage {
        guard let images = product.images as? Set<Image>, !images.isEmpty, let image = images.first, let data = image.imageData  else {
            return UIImage(named: "placeholder") ?? UIImage()
        }
        
        guard let unwrappedImage = UIImage(data: data) else {
            return UIImage(named: "placeholder") ?? UIImage()
        }
        return unwrappedImage
    }
}
