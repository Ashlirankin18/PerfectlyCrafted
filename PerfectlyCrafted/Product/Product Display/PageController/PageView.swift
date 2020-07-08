//
//  PageView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    @State var currentPage = 0
    
    var body: some View {
        ZStack {
            PageViewController(viewControllers: viewControllers, currentPage: $currentPage)
            VStack {
                Spacer()
                PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
            }
        }
    }
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
}

struct Page: View {
    
    var image: UIImage
    
    var body: some View {
        SwiftUI.Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.top)
    }
}
