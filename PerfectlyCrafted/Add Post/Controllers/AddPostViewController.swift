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
    
    private lazy var addProductHeaderView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateHeaderView()
    }
    
    private func configureTableView() {
        addGameTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        addGameTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        addGameTableView.estimatedRowHeight = UITableView.automaticDimension
        addGameTableView.dataSource = self
        addGameTableView.delegate = self
        addGameTableView.reloadData()
    }
    
    private func updateHeaderView() {
        addProductHeaderView.addImageButtonTapped = { 
            print("TO DO Present action sheet.")
        }
    }
}

extension AddPostViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
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
    
    // MARK: - DescriptionTableViewCellDelegate
    
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

extension AddPostViewController: UITableViewDelegate {
    
    // MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        addProductHeaderView.viewModel = AddProductHeaderView.ViewModel(image: UIImage(named: "placeholder") ?? UIImage())
        return addProductHeaderView
    }
}
