//
//  ImagePickerManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/22/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import YPImagePicker

/// Subscribe to this protocol to receive a notification when the user is finished picking photos
protocol ImagePickerManagerDelegate: AnyObject {
    
    /// Called when the user is finished choosing photos.
    /// - Parameters:
    ///   - imagePickerManager: The image picker manager
    ///   - photos: The user's chosen photos
    func imagePickerDidFinishPicking(imagePickerManager: ImagePickerManager, photos: [UIImage])
}

/// Contains the logic require for selecting multiple images.
class ImagePickerManager {
    
    private weak var presentingViewController: UIViewController?
    
    weak var delegate: ImagePickerManagerDelegate?
    
    /// Creates a new instance of `ImagePickerManager`.
    /// - Parameter presentingViewController: The controller present the image picker controller.
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    private lazy var imagePicker: YPImagePicker = {
        var configuration = YPImagePickerConfiguration()
        configuration.library.maxNumberOfItems = 4
        let picker = YPImagePicker(configuration: configuration)
        return picker
    }()
    
    /// Presents the image picker controller.
    func presentImagePickerController() {
        presentingViewController?.present(imagePicker, animated: true)
        imagePickerDidFinishPicking()
    }
    
    private func imagePickerDidFinishPicking() {
        imagePicker.didFinishPicking {[unowned self] (items, _) in
            var images = [UIImage]()
            for item in items {
                switch item {
                case let .photo(p: photo):
                    images.append(photo.image)
                case .video:
                    break
                }
            }
            self.delegate?.imagePickerDidFinishPicking(imagePickerManager: self, photos: images)
            self.imagePicker.dismiss(animated: true)
        }
    }
}
