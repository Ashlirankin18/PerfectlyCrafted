//
//  EditPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/10/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

final class EditPostViewController: UIViewController {
    
    @IBOutlet private weak var editPostTableView: UITableView!
    @IBOutlet private weak var deleteButton: UIButton!
    
    private lazy var dataSource: AddPostTableViewDataSource = {
        let ds = AddPostTableViewDataSource { (cell, indexPath) -> UITableViewCell in
            return self.configureCell(cell: cell, indexPath: indexPath)
        }
        editPostTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        editPostTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        return ds
    }()
    
    private let post: Post
    private let persistenceController: PersistenceController
    private let managedObjectContext: NSManagedObjectContext
    private let localImageManager = try? LocalImageManager()
    
    private lazy var headerView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    
    private lazy var saveButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped(sender:)))
    
    init(post: Post, persistenceController: PersistenceController) {
        self.post = post
        self.persistenceController = persistenceController
        self.managedObjectContext = persistenceController.newMainContext
        super.init(nibName: "EditPostViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editPostTableView.delegate = self
        editPostTableView.dataSource = dataSource
        configureBarButtonItems()
    }
    
    private func configureBarButtonItems() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func cancelButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped(sender: UIBarButtonItem) {
        persistenceController.saveContext(context: managedObjectContext)
        dismiss(animated: true)
    }
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        if let id = post.id {
            persistenceController.deleteObject(with: id, on: persistenceController.viewContext)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func configureCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        let post = self.post
        
        switch indexPath.row {
        case 0:
            guard let cell = cell as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = TitleTableViewCell.ViewModel(title: post.title ?? "")
            
            cell.textFieldDidEndEditing = { [weak self] textField in
                
                self?.updatePost(title: textField.text)
            }
            return cell
        case 1:
            guard let cell = cell as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = DescriptionTableViewCell.ViewModel(placeholderColor: .black, placeholder: post.postDescription ?? "Give your post a description")
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil ) {
        guard let id = post.id, let initialPost = persistenceController.retrieveObject(with: id, on: managedObjectContext) else {
            return
        }
        if let title = title {
            initialPost.title = title
        }
        if let postDescription = postDescription {
            initialPost.postDescription = postDescription
        }
        if let photoIdentifier = photoIdentifier {
            initialPost.photoIdentfier = photoIdentifier
        }
        if let imageData = imageData {
            initialPost.image = imageData
        }
    }
}

extension EditPostViewController: DescriptionTableViewCellDelegate {
    
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize) {
        let size = textViewSize
        let newSize = editPostTableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            editPostTableView?.beginUpdates()
            editPostTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = editPostTableView.indexPath(for: cell) {
                editPostTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func textViewDidEndEditing(_ cell: DescriptionTableViewCell, _ text: String) {
        updatePost(postDescription: text)
    }
}

extension EditPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let photoIdentifier = post.photoIdentfier {
            localImageManager?.loadImage(forKey: photoIdentifier) { (result) in
                switch result {
                case let .success(image):
                    self.headerView.viewModel = AddProductHeaderView.ViewModel(image: image)
                case let .failure(error):
                    print(error)
                }
            }
            return headerView
        } else {
            return nil
        }
    }
}
