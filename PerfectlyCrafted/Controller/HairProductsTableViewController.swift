//
//  HairProductsTableViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class HairProductsTableViewController: UITableViewController {

  @IBOutlet weak var backButton: UIBarButtonItem!
  override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func addProductPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 3
    }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let popUpViewController = PopUpViewController()
      popUpViewController.modalTransitionStyle = .coverVertical
      popUpViewController.modalPresentationStyle = .overCurrentContext
      self.present(popUpViewController, animated: true)
    }
  }

}
