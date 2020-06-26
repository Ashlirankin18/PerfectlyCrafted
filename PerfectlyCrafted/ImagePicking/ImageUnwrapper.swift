//
//  ImageUnwrapping.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 6/26/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// Handles the unwrapping of a group of data objects to a group of images.
final class ImageUnWrapperHandler {
    
    private let imageDatas: [Data]
    
    init (imageDatas: [Data]) {
        self.imageDatas = imageDatas
    }
    
    func unwrapImages() -> [UIImage] {
        var imageArray: [UIImage] = []
        
        for data in imageDatas {
                guard let image = UIImage(data: data) else {
                    return []
                }
                imageArray.append(image)
        }
        return imageArray
    }
}
