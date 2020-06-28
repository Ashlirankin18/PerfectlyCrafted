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
    
    var product: Product
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ZStack {
                    Page(image: unwrapImages())
                        .edgesIgnoringSafeArea(.top)
                    ButtonView()
                }
                
                Text("ProductName")
                    .font(.custom("Avenir Next Bold", size: 30.0))
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Text("Product Description")
                            .font(.custom("Avenir Next Medium", size: 19.0))
                        Spacer()
                    }
                    Text("I thought...")
                        .font(.custom("Avenir Next Bold", size: 17.0))
                    Text("ProductCategory")
                        .font(.custom("Avenir Next DemiBold", size: 16.0))
                    Text("ProductExperience")
                        .font(.custom("Avenir Next DemiBold", size: 14.0))
                    Text("IsConplete")
                        .font(.custom("Avenir Next DemiBold", size: 12.0))
                }
                .padding(20.0)
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
        }
        .navigationBarItems(leading:
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    SwiftUI.Image(systemName: "chevron.left")
                        .padding()
                        .frame(width: 36.0)
                        .background(Color.white)
                        .clipShape(Circle())
                        .font(.system(size: 20.0, weight: .medium))
                        .foregroundColor(.black)
                })
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
}

struct ButtonView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 25.0) {
                    Button(action: {
                    }, label: {
                        SwiftUI.Image(systemName: "pencil")
                            .padding()
                            .frame(width: 36.0)
                            .background(Color.white)
                            .clipShape(Circle())
                            .font(.system(size: 20.0, weight: .medium))
                            .foregroundColor(.black)
                    })
                    Button(action: {
                    }, label: {
                        SwiftUI.Image(systemName: "trash.fill")
                            .padding()
                            .frame(width: 36.0)
                            .background(Color.white)
                            .clipShape(Circle())
                            .font(.system(size: 20.0, weight: .medium))
                            .foregroundColor(.black)
                    })
                    Button(action: {
                    }, label: {
                        SwiftUI.Image(systemName: "square.and.arrow.up")
                            .padding()
                            .frame(width: 36.0)
                            .background(Color.white)
                            .clipShape(Circle())
                            .font(.system(size: 20.0, weight: .medium))
                            .foregroundColor(.black)
                    })
                }
            }.padding(20.0)
            Spacer()
        }
        .padding(.top, 30.0)
    }
}
