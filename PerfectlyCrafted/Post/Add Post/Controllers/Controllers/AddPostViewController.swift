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
    
    enum ContentState {
        case creating
        case editing
    }
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var entryImageView: UIImageView!
    @IBOutlet private weak var entryDateLabel: UILabel!
    @IBOutlet private weak var cameraButton: UIButton!
    
    private let contentState: ContentState
    
    private let  managedObjectContext: NSManagedObjectContext
    
    private var postId: UUID
    
    private lazy var transitionDelegate: CardPresentationManager = CardPresentationManager()
    
    private var imagePickerController: UIImagePickerController!
    
    private var localImageManager = try? LocalImageManager()
    
    private let persistenceController: PersistenceController
    
    private var posts = [Post]()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = CircularButton(image: .cancel)
        let barbutton = UIBarButtonItem(customView: button)
        
        button.buttonTapped = { button in
            self.dismiss(animated: true)
        }
        
        return barbutton
    }()
    
    /// Creates a new instance of `PostsCollectionViewDataSource`
    /// - Parameters:
    ///   - postId: The id of the post.
    ///   - persistenceController: The persistence controller.
    init?(coder: NSCoder, postId: UUID, persistenceController: PersistenceController, contentState: ContentState) {
        self.postId = postId
        self.persistenceController = persistenceController
        self.managedObjectContext = persistenceController.newMainContext
        self.contentState = contentState
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        unregisterKeyboardNofications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.transparentNavigationController()
        configureBarButtonItems()
        descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        createPostIfNeeded()
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        descriptionTextView.delegate = self
        descriptionTextView.text = "Write Something here ..."
        descriptionTextView.textColor = .gray
        UIImagePickerController.isSourceTypeAvailable(.camera)
        titleTextField.delegate = self
        
        displayView.isHidden = true
        configureImagePickerController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerKeyboardNotifications()
    }
    
    private func configureBarButtonItems() {
        title = contentState == .creating ? "Write" : "Edit Entry"
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNofications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureImagePickerController() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) ? true : false 
    }
    
    private func presentImagePickerController() {
        present(imagePickerController, animated: true)
    }
    
    private func createPostIfNeeded() {
        switch contentState {
        case .creating:
            let newPost = Post(context: managedObjectContext)
            newPost.id = postId
            newPost.createdDate = Date()
            newPost.eventDate = nil
            newPost.image = nil
            newPost.title = nil
            newPost.postDescription = nil
            newPost.photoIdentfier = nil
            posts.append(newPost)
        case .editing:
            guard let post = persistenceController.retrievePost(with: postId, context: managedObjectContext).first else {
                return
            }
            posts.append(post)
        }
    }
    
    private func updatePost(title: String? = nil, postDescription: String? = nil, photoIdentifier: UUID? = nil, imageData: Data? = nil, eventDate: Date? = nil) {
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
                if let eventDate = eventDate {
                    post.eventDate = eventDate
                }
            }
        } catch {
            print("Error here \(error)")
        }
    }
    
    @IBAction private func cameraButtonTapped(_ sender: UIButton) {
        imagePickerController.sourceType = .camera
        presentImagePickerController()
    }
    
    @IBAction private func photoLibraryButtonTapped(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        presentImagePickerController()
    }
    
    @IBAction private func dateButtonTapped(_ sender: UIButton) {
        let datePickerController = DatePickerViewController()
        let datePickerNavigationController = UINavigationController(rootViewController: datePickerController)
        datePickerNavigationController.modalPresentationStyle = .custom
        datePickerNavigationController.transitioningDelegate = transitionDelegate
        present(datePickerNavigationController, animated: true)
        
        datePickerController.didSelectEventDate = { [weak self]  date in
            self?.updatePost(eventDate: date)
            self?.entryDateLabel.isHidden = false
            self?.entryDateLabel.text = DateFormatter.format(date: date)
        }
    }
    
    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        persistenceController.saveContext(context: managedObjectContext)
        dismiss(animated: true)
    }
    
    @objc private func tapDone(sender: Any) {
        descriptionTextView.resignFirstResponder()
    }
    
    @objc private func willShowKeyboard(notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                print("userinfo is nil")
                return
        }
        containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
        displayView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
    }
    
    @objc private func willHideKeyboard(notification: Notification) {
        containerView.transform = CGAffineTransform.identity
        displayView.transform = CGAffineTransform.identity
    }
}

extension AddPostViewController: UITextViewDelegate {
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !descriptionTextView.text.isEmpty {
            descriptionTextView.textColor = .black
            descriptionTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePost(postDescription: textView.text)
    }
}

extension AddPostViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePost(title: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                return
        }
        
        var photoIdentifier: UUID
        
        switch contentState {
        case .creating:
            photoIdentifier = UUID()
        case .editing:
            guard let post = posts.first, let postPhotoIdentifier = post.photoIdentfier else {
                return
            }
            photoIdentifier = postPhotoIdentifier
        }
        
        do {
            let data = try image.heicData()
            updatePost(photoIdentifier: photoIdentifier, imageData: data)
        } catch {
            print(error)
        }
        localImageManager?.saveImage(image, key: photoIdentifier)
        displayView.isHidden = false
        entryImageView.image = image
        entryDateLabel.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}
