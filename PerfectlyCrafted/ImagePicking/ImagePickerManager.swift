//
//  ImagePickerManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/22/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import YPImagePicker

protocol ImagePickerManagerDelegate: AnyObject {
    func imagePickerDidFinishPicking(imagePickerManager: ImagePickerManager, photos: [UIImage])
}

class ImagePickerManager {
    
    private weak var presentingViewController: UIViewController?
    
    weak var delegate: ImagePickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    private lazy var imagePicker: YPImagePicker = {
        var configuration = YPImagePickerConfiguration()
        configuration.library.maxNumberOfItems = 4
        let picker = YPImagePicker(configuration: configuration)
        return picker
    }()
    
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
