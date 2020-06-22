//
//  AddProductViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import YPImagePicker

final class AddProductViewController: UIViewController {
    
    @IBOutlet private weak var productDescriptionSwitch: UISwitch!
    @IBOutlet private weak var productExperienceSwitch: UISwitch!
    @IBOutlet private weak var productNameTextField: UITextField!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var productDescriptionTextView: UITextView!
    @IBOutlet private weak var productExperienceTextView: UITextView!
    
    private var documentId: String?
    
    private let databaseManager: DatabaseManager
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = CircularButton(image: .cancel)
        let barbutton = UIBarButtonItem(customView: button)
        
        button.buttonTapped = { button in
            self.databaseManager.removeProductFromDatabase(documentId: self.documentId ?? "")
            self.dismiss(animated: true, completion: nil)
        }
        return barbutton
    }()
    
    private lazy var imagePicker: YPImagePicker = {
        var configuration = YPImagePickerConfiguration()
        configuration.library.maxNumberOfItems = 4
        let picker = YPImagePicker(configuration: configuration)
        return picker
    }()
    
    init? (coder: NSCoder, databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerKeyboardNotifications()
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
    }
    
    deinit {
        unregisterKeyboardNofications()
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
        present(imagePicker, animated: true, completion: nil)
        
        imagePicker.didFinishPicking { (items, sucess) in
            for item in items {
                switch item {
                case let .photo(p: photo):
                    break
                case let .video(v: video):
                    break
                }
            }
        }
        
        
    }
    
    private func hideTextViewIfNeeded(textView: UITextView, isOn: Bool) {
        textView.isHidden = isOn ? false : true
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNofications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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

extension AddProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if let documentId = documentId {
            databaseManager.updateProductOnDatabase(documentId: documentId, name: text)
        } else {
            let prodcut = Product(category: "", experience: "", documentId: "", isFinished: false, name: text, imageURLS: [])
            documentId = databaseManager.postProductToDatabase(product: prodcut)
        }
        textField.resignFirstResponder()
    }
}
