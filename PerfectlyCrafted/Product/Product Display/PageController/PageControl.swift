//
//  PageControl.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/29/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    
    typealias UIViewType = UIPageControl
    
    var numberOfPages: Int
    
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
