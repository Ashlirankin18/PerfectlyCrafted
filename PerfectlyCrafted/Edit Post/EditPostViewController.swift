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
    
    private var imagePickerController: UIImagePickerController!
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    
    private lazy var saveButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped(sender:)))
    
    /// Creates a new instance of `EditPostViewController`
    /// - Parameters:
    ///   - post: The post to be edited
    ///   - persistenceController: The persistence controller which handles the persisting of ojects.
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
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        updateHeaderView()
    }
    
    private func configureBarButtonItems() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func updateHeaderView() {
        headerView.addImageButtonTapped = { [weak self] in
            self?.presentAlertController()
        }
    }
    
    private func presentAlertController () {
        let alertController = UIAlertController(title: "Add image to this post using:", message: "", preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.imagePickerController.sourceType = .photoLibrary
            self?.presentImagePickerController()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            action.isEnabled = !UIImagePickerController.isSourceTypeAvailable(.camera) ? false : true
            self?.imagePickerController.sourceType = .camera
            self?.presentImagePickerController()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func presentImagePickerController() {
        present(imagePickerController, animated: true)
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
    
    // MARK: - DescriptionTableViewCellDelegate
    
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
    
    // MARK: - UITableViewDelegate
    
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

extension EditPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                logAssertionFailure(message: "Could not load image.")
                return
        }
        let photoIdentifier = UUID()
        do {
            let data = try image.heicData()
            updatePost(photoIdentifier: photoIdentifier, imageData: data)
        } catch {
            print(error)
        }
        localImageManager?.saveImage(image, key: photoIdentifier)
        
        headerView.viewModel = AddProductHeaderView.ViewModel(image: image)
        dismiss(animated: true, completion: nil)
    }
}
