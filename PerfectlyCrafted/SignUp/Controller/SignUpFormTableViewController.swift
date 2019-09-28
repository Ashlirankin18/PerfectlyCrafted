//
//  SignUpFormTableViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 9/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UITableViewController` subclass which will display a signup form to the user
final class SignUpFormTableViewController: UITableViewController {
  
  
  @IBOutlet private weak var userNameTextfield: UITextField!
  @IBOutlet private weak var hairTypeTextField: UITextField!
  @IBOutlet private weak var aboutMeTextView: UITableViewCell!
  
  @IBAction private func signUpButtonPressed(_ sender: UIButton) {
    
  }
}
