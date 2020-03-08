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
    
    @IBOutlet private weak var addGameTableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var postId = UUID()
    
    private lazy var addProductHeaderView: AddProductHeaderView! = AddProductHeaderView.instantiateViewFromNib()
    
    private var imagePickerController: UIImagePickerController!
    
    private var localImageManager = try! LocalImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateHeaderView()
        addKeyboardNotificationObservers()
        createPost()
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
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
        let newPost = Post(context: context)
        newPost.id = postId
        newPost.date = Date()
        newPost.image = nil
        newPost.title = ""
        newPost.postDescription = ""
        newPost.photoIdentfier = nil
    }
    
    private func addKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        savePost()
        dismiss(animated: true)
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil ) {
        let post = Post(context: context)
        post.title = title
        post.postDescription = postDescription
        post.photoIdentfier = photoIdentifier
        post.image = imageData
    }
    
    private func savePost() {
        do {
            try context.save()
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
            self?.addGameTableView.transform = CGAffineTransform.identity
            }, completion: nil)
        
    }
    
    @objc private func willShowKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        addGameTableView.transform = CGAffineTransform(translationX: 0, y: -keyboardScreenEndFrame.height)
        saveButton.transform = CGAffineTransform(translationX: 0, y: -keyboardScreenEndFrame.height)
        
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
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
            cell.textFieldDidEndEditing = { [weak self] (textfield) in
                self?.updatePost(title: textfield.text)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.viewModel = DescriptionTableViewCell.ViewModel(placeholder: "Enter description here.")
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
    
    func textViewDidEndEditing(_ cell: DescriptionTableViewCell, _ text: String) {
        updatePost(postDescription: text)
        savePost()
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


