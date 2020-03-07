//
//  AddPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class AddPostViewController: UIViewController {
    
    @IBOutlet private weak var addGameTableView: UITableView!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGameTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        addGameTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        addGameTableView.estimatedRowHeight = UITableView.automaticDimension
        addGameTableView.dataSource = self
        addGameTableView.reloadData()
    }
}
extension AddPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension AddPostViewController: DescriptionTableViewCellDelegate {
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize) {
        let size = textViewSize
        let newSize = addGameTableView.sizeThatFits(CGSize(width: size.width,
                                                           height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            addGameTableView?.beginUpdates()
            addGameTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = addGameTableView.indexPath(for: cell) {
                addGameTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
    
}

