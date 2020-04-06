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
    
    private let contentState: ContentState
    
    private let  managedObjectContext: NSManagedObjectContext
    
    private var postId: UUID
    
    private var imagePickerController: UIImagePickerController!
    
    private var localImageManager = try? LocalImageManager()
    
    private let persistenceController: PersistenceController
    
    private var posts = [Post]()
    
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItems()
        
        createPostIfNeeded()
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
    }
    
    private func configureBarButtonItems() {
        title = contentState == .creating ? "Write" : "Edit Entry"
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true)
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
            guard let post = persistenceController.retrieveObjects(with: postId, context: managedObjectContext).first else {
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
            } else {
                logAssertionFailure(message: "Could not retrieve post.")
            }
        } catch {
            logAssertionFailure(message: "Error here \(error)")
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
        
    }
    
    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        persistenceController.saveContext(context: managedObjectContext)
        dismiss(animated: true)
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
        
        dismiss(animated: true, completion: nil)
    }
}
