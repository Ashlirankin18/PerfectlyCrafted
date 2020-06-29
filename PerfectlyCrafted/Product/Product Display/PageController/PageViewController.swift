//
//  SwiftUIView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/27/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
   
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    typealias UIViewControllerType = UIPageViewController
    
    var viewControllers: [UIViewController]
    
    @Binding var currentPage: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.dataSource = context.coordinator
        pageController.delegate = context.coordinator
        return pageController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([viewControllers[currentPage]], direction: .forward, animated: true)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }
            let previousIndex = index - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard parent.viewControllers.count > previousIndex else {
                return nil
            }
            return parent.viewControllers[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            let nextIndex = index + 1
            let orderedViewControllersCount = parent.viewControllers.count
            
            guard orderedViewControllersCount != nextIndex else {
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            return parent.viewControllers[nextIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.viewControllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
