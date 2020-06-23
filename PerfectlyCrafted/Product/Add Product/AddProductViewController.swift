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
  
    private var product = [Product]()
    
    init? (coder: NSCoder, persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
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
        imagePickerManager.delegate = self
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
    }
    
    @IBAction private func submitButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction private func photoLibraryButtonTapped(_ sender: UIButton) {
        imagePickerManager.presentImagePickerController()
    }
    
    private func hideTextViewIfNeeded(textView: UITextView, isOn: Bool) {
        textView.isHidden = isOn ? false : true
    }
}

extension AddProductViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        textField.resignFirstResponder()
    }
}

extension AddProductViewController: ImagePickerManagerDelegate {
    // MARK: - ImagePickerManagerDelegate
    func imagePickerDidFinishPicking(imagePickerManager: ImagePickerManager, photos: [UIImage]) {
        guard !photos.isEmpty else {
            return
        }
        print(photos)
    }
}
