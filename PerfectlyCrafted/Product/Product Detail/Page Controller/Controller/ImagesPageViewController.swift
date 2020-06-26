//
//  ImagesPageViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

protocol ImagesPageViewControllerDelegate: AnyObject {
    
    func imagesPageViewController(imagesPageViewController: ImagesPageViewController,
                                  didUpdatePageCount count: Int)
    
    func imagesPageViewController(imagesPageViewController: ImagesPageViewController,
                                  didUpdatePageIndex index: Int)
}

/// 
final class ImagesPageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController] = []
    
    weak var imagesPageViewControllerDelegate: ImagesPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let imageOne = orderedViewControllers.first {
            setViewControllers([imageOne], direction: .forward, animated: true, completion: nil)
        }
        imagesPageViewControllerDelegate?.imagesPageViewController(imagesPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }
}

extension ImagesPageViewController: UIPageViewControllerDataSource {
    
    //MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
}

extension ImagesPageViewController: UIPageViewControllerDelegate {
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstViewController) {
            imagesPageViewControllerDelegate?.imagesPageViewController(imagesPageViewController: self, didUpdatePageIndex: index)
        }
    }
}
