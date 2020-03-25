//
//  AddPostTableViewDataSource.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/9/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// Datasource of the `AddPostViewCaontroller`.
final class AddPostTableViewDataSource: NSObject, UITableViewDataSource {
    
    typealias CellConfiguration = (UITableViewCell, IndexPath) -> UITableViewCell
    
    private let cellConfiguration: (CellConfiguration)
    
    /// Creates a new instance of `AddPostTableViewDataSource`
    /// - Parameter cellConfiguration: the cell configuration.
    init(cellConfiguration: @escaping CellConfiguration) {
        self.cellConfiguration = cellConfiguration
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleTableViewCell  else {
                return UITableViewCell()
            }
            return cellConfiguration(cell, indexPath)
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell  else {
                return UITableViewCell()
            }
            return cellConfiguration(cell, indexPath)
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as? DateNameTableViewCell  else {
                return UITableViewCell()
            }
            return cellConfiguration(cell, indexPath)
        default:
            return UITableViewCell()
        }
    }
}
