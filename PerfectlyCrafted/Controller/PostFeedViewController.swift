//
//  PostFeedViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/4/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PostFeedViewController: UIViewController {

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var postCaption: UITextView!
  
  @IBOutlet weak var post: UIButton!
  public var productToPost: ProductModel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  init(product:ProductModel){
    super.init(nibName: nil, bundle: nil)
    self.productToPost = product
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @IBAction func postButtonPressed(_ sender: UIButton) {
    print("post")
  }
  

  
}
