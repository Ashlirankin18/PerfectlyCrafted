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
    
    var persistenceController: PersistenceController
   
    /// The product that the user chooses.
    var product: Product

    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                PageView(getPages())
                    .edgesIgnoringSafeArea(.top)
                ButtonView(product: product, persistenceController: persistenceController)
            }
            .edgesIgnoringSafeArea(.top)
            ProductDescriptionView(product: product)
                .padding(20.0)
        }
        
        .navigationBarItems(leading:
                                HStack {
                                    RoundButton(imageName: "chevron.left") {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                })
        .navigationBarTitle(Text(""), displayMode: .inline)
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
            return [UIImage(named: "placeholder") ?? UIImage()]
        }
        let imageDatas = images.map({ $0.imageData })
        var imageArray: [UIImage] = []
        
        for imageData in imageDatas {
            guard let data = imageData, let image = UIImage(data: data) else {
                return [UIImage(named: "placeholder") ?? UIImage()]
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

struct ButtonView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showingAlert: Bool = false
    
    var product: Product
    
    var persistenceController: PersistenceController
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 25.0) {
                    RoundButton(imageName: "pencil") {
                        print("here")
                    }
                    RoundButton(imageName: "trash.fill") {
                        showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Delete Product"), message: Text("Are you sure you want to delete this product?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                            persistenceController.deleteObject(with: product, on: managedObjectContext)
                            presentationMode.wrappedValue.dismiss()
                        }))
                    }
                    RoundButton(imageName: "square.and.arrow.up") {
                    }
                }
            }.padding(20.0)
            Spacer()
        }
        .padding(.top, 30.0)
    }
}
