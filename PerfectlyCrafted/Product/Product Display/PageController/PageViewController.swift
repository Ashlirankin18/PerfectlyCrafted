//
//  SwiftUIView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIPageViewController
    
    var viewControllers: [UIViewController]
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true)
    }
    
    func makeCoordinator() -> Void {
        Coordinator()
    }
}

class Coordinator: NSObject, UIPageViewControllerDataSource {
    
    var parent: PageViewController
    
    init(_ pageViewController: PageViewController) {
        self.parent = pageViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = parent.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        if index == 0 {
            return parent.viewControllers.last
        }
        return parent.viewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = parent.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        if index + 1 == parent.viewControllers.count {
            return parent.viewControllers.first
        }
        return parent.viewControllers[index + 1]
    }
}
