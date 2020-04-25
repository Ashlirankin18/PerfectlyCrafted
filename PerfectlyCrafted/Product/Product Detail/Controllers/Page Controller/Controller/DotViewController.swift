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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imagesPageViewController = segue.destination as? ImagesPageViewController {
            imagesPageViewController.imagesPageViewControllerDelegate = self
        }
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
