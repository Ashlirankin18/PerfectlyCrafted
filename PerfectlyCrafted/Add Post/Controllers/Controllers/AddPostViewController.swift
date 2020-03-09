//
//  AddPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/7/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

final class AddPostViewController: UIViewController {
    
    @IBOutlet private weak var addPostTableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    
    private let  childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    private var postId: UUID
    
    private var imagePickerController: UIImagePickerController!
    
    private var localImageManager = try! LocalImageManager()
   
    private let persistenceController: PersistenceController
    
    private var posts = [Post]()
   
    private lazy var addPostTableViewDataSource: AddPostTableViewDataSource = {
        let addPostTableViewDataSource = AddPostTableViewDataSource { (tableView, index) -> UITableViewCell in
            self.configureCell(tableView: tableView,indexPath: index)
        }
        addPostTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        addPostTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        return addPostTableViewDataSource
    }()
   
    private lazy var addProductHeaderView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    init(postId: UUID, persistenceController: PersistenceController) {
        self.postId = postId
        self.persistenceController = persistenceController
       
        super.init(nibName: "AddPostViewController", bundle: Bundle.main)
         childContext.parent = persistenceController.mainContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateHeaderView()
        addKeyboardNotificationObservers()
        createPost()
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
    }
    
    private func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.textFieldDidEndEditing = { [weak self] textfield in
                self?.updatePost(title: textfield.text)
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.viewModel = DescriptionTableViewCell.ViewModel(placeholder: "Give your entry a description")
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
        let newPost = Post(context: childContext)
        newPost.id = postId
        newPost.date = Date()
        newPost.image = nil
        newPost.title = nil
        newPost.postDescription = nil
        newPost.photoIdentfier = nil
        posts.append(newPost)
    }
    
    private func addKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        saveToChildContext()
        dismiss(animated: true)
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil ) {
        
        guard let initialPost = posts.first, let id = initialPost.id else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Post> = NSFetchRequest<Post>()
        fetchRequest.entity = Post.entity()
        
        do {
            if let post = try childContext.fetch(fetchRequest).first(where: { (post) -> Bool in
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
    
    private func saveToChildContext() {
        do {
            try childContext.save()
        } catch {
            print("error: \(error)")
        }
    }
    
    @objc private func willHideKeyboard(notification: Notification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.0, options: [], animations: { [weak self] in
            self?.saveButton.transform = CGAffineTransform.identity
            self?.addPostTableView.transform = CGAffineTransform.identity
            }, completion: nil)
        
    }
    
    @objc private func willShowKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        addPostTableView.transform = CGAffineTransform(translationX: 0, y: -keyboardScreenEndFrame.height)
        saveButton.transform = CGAffineTransform(translationX: 0, y: -keyboardScreenEndFrame.height)
        
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
}

extension AddPostViewController: DescriptionTableViewCellDelegate {
    
    // MARK: - DescriptionTableViewCellDelegate
    
    func updateHeightOfRow(_ cell: DescriptionTableViewCell, _ textViewSize: CGSize) {
        let size = textViewSize
        let newSize = addPostTableView.sizeThatFits(CGSize(width: size.width,
                                                           height: CGFloat.greatestFiniteMagnitude))
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
    
    // MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        addProductHeaderView.viewModel = AddProductHeaderView.ViewModel(image: UIImage(systemName: "camera.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 300.0)) ?? UIImage())
        return addProductHeaderView
    }
}

extension AddPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else{
                print("no original image could be found")
                return
        }
        let photoIdentifier = UUID()
        do {
            let data = try image.heicData()
            updatePost(photoIdentifier: photoIdentifier, imageData: data)
        } catch {
            print(error)
        }
        localImageManager.saveImage(image, key: photoIdentifier)
        addProductHeaderView.viewModel = AddProductHeaderView.ViewModel(image: image)
        dismiss(animated: true, completion: nil)
    }
}


