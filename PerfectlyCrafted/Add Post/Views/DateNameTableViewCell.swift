//
//  DateNameTableViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class DateNameTableViewCell: UITableViewCell {
  
    struct ViewModel {
        let date: String
    }
    
    var viewModel: ViewModel? {
        didSet {
            textLabel?.text = "Date"
        }
    }
}
