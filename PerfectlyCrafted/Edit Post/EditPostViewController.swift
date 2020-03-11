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
        let ds =  AddPostTableViewDataSource { (cell, indexPath) -> UITableViewCell in
            return self.configureCell(cell: cell, indexPath: indexPath)
        }
        editPostTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        editPostTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        return ds
    }()
    
    private let postId: UUID
    private let persistenceController: PersistenceController
    private let managedObjectContext: NSManagedObjectContext
    private let localImageManager: LocalImageManager
    private lazy var headerView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    
    private lazy var saveButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped(sender:)))
    
    init(postId: UUID, persistenceController: PersistenceController, localImageManager: LocalImageManager) {
        self.postId = postId
        self.persistenceController = persistenceController
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.localImageManager = localImageManager
        super.init(nibName: "EditPostViewController", bundle: nil)
        
        managedObjectContext.parent = persistenceController.mainContext
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
        do {
            try managedObjectContext.save()
        } catch {
            print("Error!")
        }
        dismiss(animated: true)
    }
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        
    }
    
    private func configureCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        guard let post = retrievePost(with: postId) else {
            return UITableViewCell()
        }
        
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
    
    private func retrievePost(with identifier: UUID) -> Post? {
        var posts = [Post]()
        
        let fetchRequest = NSFetchRequest<Post>()
        fetchRequest.entity = Post.entity()
        fetchRequest.predicate = NSPredicate(format: "id == %@", postId.description)
        
        do {
            let fetchedPost =  try persistenceController.mainContext.fetch(fetchRequest)
            posts = fetchedPost
        } catch {
            print("ERROR! !!!!!")
        }
        return posts.first
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil ) {
        
        guard let initialPost = retrievePost(with: postId), let id = initialPost.id else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Post> = NSFetchRequest<Post>()
        fetchRequest.entity = Post.entity()
        
        do {
            if let post = try managedObjectContext.fetch(fetchRequest).first(where: { (post) -> Bool in
                post.id == id
            }) {
                if let title = title {
                    post.title = title
                }
                if let postDescription = postDescription {
                    post.postDescription = postDescription
                }
                if let photoIdentifier = photoIdentifier {
                    post.photoIdentfier = photoIdentifier
                }
                if let imageData = imageData {
                    post.image = imageData
                }
            } else {
                print("here")
            }
        } catch {
            print("Error here \(error)")
        }
    }
    
    
}
extension EditPostViewController: DescriptionTableViewCellDelegate {
    
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize) {
        let size = textViewSize
        let newSize = editPostTableView.sizeThatFits(CGSize(width: size.width,
                                                            height: CGFloat.greatestFiniteMagnitude))
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
        
        if let post = retrievePost(with: postId), let photoIdentifier = post.photoIdentfier {
            localImageManager.loadImage(forKey: photoIdentifier) { (result) in
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
