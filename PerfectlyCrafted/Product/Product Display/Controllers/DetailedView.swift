//
//  DetailedView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct DetailedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// The product that the user chooses.
    var product: Product
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    PageView(getPages())
                        .edgesIgnoringSafeArea(.top)
                    ButtonView()
                }
                Spacer()
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
                .padding(20.0)
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarItems(leading:
                                HStack {
                                    RoundButton(imageName: "chevron.left") {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                })
        .navigationBarBackButtonHidden(true)
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
    
   private func unwrapImages() -> [UIImage] {
        guard let images = product.images as? Set<Image>, !images.isEmpty else {
            return []
        }
        let imageDatas = images.map({ $0.imageData })
        var imageArray: [UIImage] = []
        
        for imageData in imageDatas {
            guard let data = imageData, let image = UIImage(data: data) else {
                return []
            }
            imageArray.append(image)
        }
        return imageArray
    }
    
   private func getPages() -> [Page] {
        var pages = [Page]()
        for image in 0..<unwrapImages().count {
            let page = Page(image: unwrapImages()[image])
            pages.append(page)
        }
        return pages
    }
}
