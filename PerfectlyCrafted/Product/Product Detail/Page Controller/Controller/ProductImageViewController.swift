//
//  ProductImageViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/23/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

class ProductImageViewController: UIViewController {

    @IBOutlet private weak var productImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = image else {
            return
        }
        productImageView.image = image
    }
}
