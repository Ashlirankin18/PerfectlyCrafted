//
//  AddProductViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import YPImagePicker
import CoreData

final class AddProductViewController: UIViewController {
    
    @IBOutlet private weak var productDescriptionSwitch: UISwitch!
    @IBOutlet private weak var productExperienceSwitch: UISwitch!
    @IBOutlet private weak var productNameTextField: UITextField!
    @IBOutlet private weak var productCategoryTextField: UITextField!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var productDescriptionTextView: UITextView!
    @IBOutlet private weak var productExperienceTextView: UITextView!
    
    private lazy var imagePickerManager = ImagePickerManager(presentingViewController: self)
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = CircularButton(image: .cancel)
        let barbutton = UIBarButtonItem(customView: button)
        
        button.buttonTapped = { button in
            self.dismiss(animated: true, completion: nil)
        }
        return barbutton
    }()
    
    private lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(raisedViews: [containerView, displayView])
    
    private let persistenceController: PersistenceController
    private let managedObjectContext: NSManagedObjectContext
    
    private var products = [Product]()
    private let productId: UUID
    
    init? (coder: NSCoder, persistenceController: PersistenceController, productId: UUID) {
        self.persistenceController = persistenceController
        self.productId = productId
        self.managedObjectContext = persistenceController.newMainContext
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver.registerKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"
        productDescriptionSwitch.isOn = false
        productExperienceSwitch.isOn = false
        hideTextViewIfNeeded(textView: productDescriptionTextView, isOn: false)
        hideTextViewIfNeeded(textView: productExperienceTextView, isOn: false)
        navigationController?.transparentNavigationController()
        navigationItem.leftBarButtonItem = cancelButton
        productNameTextField.delegate = self
        productCategoryTextField.delegate = self
        imagePickerManager.delegate = self
        productDescriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        productExperienceTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        createProductIfNeeded()
    }
    
    private func createProductIfNeeded() {
        let product = Product(context: managedObjectContext)
        product.name = nil
        product.experience = nil
        product.category = nil
        product.isfinished = false
        product.productDescription = nil
        product.entryDate = Date()
        products.append(product)
    }
    
    private func updateProduct(name: String? = nil, experience: String? = nil, images: Set<Image>? = nil, isFinished: Bool = false, category: String? = nil, productDescription: String? = nil) {
        let fetchRequest: NSFetchRequest<Product> = NSFetchRequest<Product>()
        fetchRequest.entity = Product.entity()
        
        do {
            if let product = try managedObjectContext.fetch(fetchRequest).first(where: { (product) -> Bool in
                product.id == productId
            }) {
                if let name = name {
                    product.name = name
                }
                
                if let experience = experience {
                    product.experience = experience
                }
                
                if let images = images {
                    product.images = images as NSSet
                }
                
                if let category = category {
                    product.category = category
                }
                
                if let productDescription = productDescription {
                    product.productDescription = productDescription
                }
                
                product.isfinished = isFinished
            }
        } catch {
            print("Error here \(error)")
        }
    }
    
    deinit {
        keyboardObserver.unregisterKeyboardNofications()
    }
    
    @IBAction private func productDescriptionSwicthTapped(_ sender: UISwitch) {
        hideTextViewIfNeeded(textView: productDescriptionTextView, isOn: sender.isOn)
    }
    
    @IBAction private func productExperienceSwitchTapped(_ sender: UISwitch) {
        hideTextViewIfNeeded(textView: productExperienceTextView, isOn: sender.isOn)
    }
    
    @IBAction private func isProductCompletedTapped(_ sender: UISwitch) {
        if sender.isOn {
            updateProduct(isFinished: true)
        }
    }
    
    @IBAction private func submitButtonPressed(_ sender: UIButton) {
        persistenceController.saveContext(context: managedObjectContext)
        dismiss(animated: true)
    }
    
    @IBAction private func photoLibraryButtonTapped(_ sender: UIButton) {
        imagePickerManager.presentImagePickerController()
    }
    
    private func hideTextViewIfNeeded(textView: UITextView, isOn: Bool) {
        textView.isHidden = isOn ? false : true
    }
    
    @objc private func tapDone(sender: Any) {
        productDescriptionTextView.resignFirstResponder()
        productExperienceTextView.resignFirstResponder()
    }
}

extension AddProductViewController: UITextViewDelegate {
    
    // MARK: - UITextFieldDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            textView.textColor = .black
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == productExperienceTextView && productExperienceSwitch.isOn {
            updateProduct(experience: textView.text)
        } else if textView == productDescriptionTextView && productDescriptionSwitch.isOn {
            updateProduct(productDescription: textView.text)
        }
    }
}

extension AddProductViewController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == productNameTextField {
            productNameTextField.resignFirstResponder()
        } else if textField == productCategoryTextField {
            productCategoryTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == productNameTextField {
            guard let text = textField.text else {
                return
            }
            updateProduct(name: text)
        } else if textField == productCategoryTextField {
            guard let text = textField.text else {
                return
            }
            updateProduct(category: text)
        } else {
            print("here")
        }
    }
}

extension AddProductViewController: ImagePickerManagerDelegate {
    // MARK: - ImagePickerManagerDelegate
    func imagePickerDidFinishPicking(imagePickerManager: ImagePickerManager, photos: [UIImage]) {
        guard let product = products.first, !photos.isEmpty else {
            return
        }
        
        var photoSet = Set<Image>()
        for photo in photos {
            let image = Image(context: managedObjectContext)
            image.id = UUID()
            image.imageData = photo.pngData()
            image.product = product
            photoSet.insert(image)
        }
        updateProduct(images: photoSet)
    }
}
