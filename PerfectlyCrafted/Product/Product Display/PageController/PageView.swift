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
    
    var body: some View {
        PageViewController(viewControllers: viewControllers)
    }
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
}

struct Page: View {
   
    var image: UIImage
    
    var body: some View {
        SwiftUI.Image(uiImage: image)
            .aspectRatio(contentMode: .fit)
    }
}
