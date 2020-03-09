//
//  AddPostTableViewDataSource.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/9/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

class AddPostTableViewDataSource: NSObject, UITableViewDataSource {
    
    typealias CellConfiguration = (UITableView, IndexPath) -> UITableViewCell
    
    let cellConfiguration: CellConfiguration
    
    init(cellConfiguration: @escaping CellConfiguration) {
        self.cellConfiguration = cellConfiguration
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellConfiguration(tableView,indexPath)
        case 1:
            return cellConfiguration(tableView,indexPath)
        default:
            return UITableViewCell()
        }
    }
}
