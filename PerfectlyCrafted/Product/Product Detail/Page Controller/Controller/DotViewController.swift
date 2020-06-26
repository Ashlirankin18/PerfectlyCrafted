//
//  DotViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/24/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class DotViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imagePageControl: UIPageControl!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imagesPageViewController = segue.destination as? ImagesPageViewController {
            imagesPageViewController.imagesPageViewControllerDelegate = self
            imagesPageViewController.orderedViewControllers = newViewController(viewControllerIdentifier: "ImageOne", count: images.count)
        }
    }
    
    private func newViewController(viewControllerIdentifier: String, count: Int) -> [UIViewController] {
        var controllers = [UIViewController]()
        
        for index in 0..<images.count {
            guard let controller = UIStoryboard(name: "Pages", bundle: nil).instantiateViewController(identifier: viewControllerIdentifier) as? ProductImageViewController else {
                return [UIViewController()]
            }
            controller.image = images[index]
            controllers.append(controller)
        }
        return controllers
    }
}

extension DotViewController: ImagesPageViewControllerDelegate {
    func imagesPageViewController(imagesPageViewController: ImagesPageViewController, didUpdatePageCount count: Int) {
        imagePageControl.numberOfPages = count
    }
    
    func imagesPageViewController(imagesPageViewController: ImagesPageViewController, didUpdatePageIndex index: Int) {
        imagePageControl.currentPage = index
    }
}
