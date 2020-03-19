//
//  AddPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

/// `UIViewController` subclss which allows the user to add a post.
final class AddPostViewController: UIViewController {
    
    @IBOutlet private weak var addPostTableView: UITableView!
    
    private let  managedObjectContext: NSManagedObjectContext
    
    private var postId: UUID
    
    private var imagePickerController: UIImagePickerController!
    
    private var localImageManager = try? LocalImageManager()
    
    private let persistenceController: PersistenceController
    
    private var posts = [Post]()
    
    private lazy var addPostTableViewDataSource: AddPostTableViewDataSource = {
        let addPostTableViewDataSource = AddPostTableViewDataSource { (cell, indexPath) -> UITableViewCell in
            return self.configureCell(cell: cell, indexPath: indexPath)
        }
        addPostTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        addPostTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        return addPostTableViewDataSource
    }()
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    
    private lazy var saveButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped(sender:)))
    
    private lazy var addProductHeaderView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    /// Creates a new instance of `PostsCollectionViewDataSource`
    /// - Parameters:
    ///   - postId: The id of the post.
    ///   - persistenceController: The persistence controller.
    init(postId: UUID, persistenceController: PersistenceController) {
        self.postId = postId
        self.persistenceController = persistenceController
        self.managedObjectContext = persistenceController.newMainContext
        super.init(nibName: "AddPostViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItems()
        configureTableView()
        updateHeaderView()
        createPost()
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
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
    
    private func configureCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = cell as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = TitleTableViewCell.ViewModel(title: "")
            cell.textFieldDidEndEditing = { [weak self] textfield in
                self?.updatePost(title: textfield.text)
            }
            return cell
        case 1:
            guard let cell = cell as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            let existingDescription = "Give your entry a description"
            let placeholderColor: UIColor = .gray
            cell.delegate = self
            cell.viewModel = DescriptionTableViewCell.ViewModel(placeholderColor: placeholderColor, placeholder: existingDescription)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func configureTableView() {
        addPostTableView.estimatedRowHeight = UITableView.automaticDimension
        addPostTableView.dataSource = addPostTableViewDataSource
        addPostTableView.delegate = self
        addPostTableView.reloadData()
    }
    
    private func updateHeaderView() {
        addProductHeaderView.addImageButtonTapped = { [weak self] in
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
    
    private func createPost() {
        let newPost = Post(context: managedObjectContext)
        newPost.id = postId
        newPost.date = Date()
        newPost.image = nil
        newPost.title = nil
        newPost.postDescription = nil
        newPost.photoIdentfier = nil
        posts.append(newPost)
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil ) {
        let fetchRequest: NSFetchRequest<Post> = NSFetchRequest<Post>()
        fetchRequest.entity = Post.entity()
        
        do {
            if let post = try managedObjectContext.fetch(fetchRequest).first(where: { (post) -> Bool in
                post.id == postId
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
                logAssertionFailure(message: "Could not retrieve post.")
            }
        } catch {
            logAssertionFailure(message: "Error here \(error)")
        }
    }
}

extension AddPostViewController: DescriptionTableViewCellDelegate {
    
    // MARK: - DescriptionTableViewCellDelegate
    
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize) {
        let size = textViewSize
        let newSize = addPostTableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            addPostTableView?.beginUpdates()
            addPostTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = addPostTableView.indexPath(for: cell) {
                addPostTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func textViewDidEndEditing(_ cell: DescriptionTableViewCell, _ text: String) {
        updatePost(postDescription: text)
    }
}

extension AddPostViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let photoIdentifier = posts.first?.photoIdentfier {
            localImageManager?.loadImage(forKey: photoIdentifier) { (result) in
                switch result {
                case let .success(image):
                    self.addProductHeaderView.viewModel = AddProductHeaderView.ViewModel(image: image)
                case let .failure(error):
                    print(error)
                }
            }
        }
        return addProductHeaderView
    }
}

extension AddPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        addProductHeaderView.viewModel = AddProductHeaderView.ViewModel(image: image)
        dismiss(animated: true, completion: nil)
    }
}
