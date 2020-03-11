//
//  UIImage+HEIC.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    
    /// An enum that represents errors in creating `HEIC` data
    enum HEICError: Error {
        /// Represents a device that does not support the heic format.
        case heicNotSupported
        
        /// Represents a missing `CGImage`.
        case cgImageMissing
        
        /// Represents inability to finalize and write the image data.
        case couldNotFinalize
    }
    
    /// Converts the corresponding image to data encoded with the HEIC file type.
    /// - Parameter compressionQuality: The desired compression quality to use when writing to an image destination. Defaults to 0.5. A value of 0.0 equates to maximum compression while 1.0 equates to lossless compression if the destination format supports it.
    func heicData(compressionQuality: CGFloat = 0.5) throws -> Data {
        let data = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(data, AVFileType.heic as CFString, 1, nil) else {
            throw HEICError.heicNotSupported
        }
        
        guard let cgImage = self.cgImage else {
            throw HEICError.cgImageMissing
        }
        
        let options: NSDictionary = [kCGImageDestinationLossyCompressionQuality: compressionQuality]
        
        CGImageDestinationAddImage(imageDestination, cgImage, options)
        guard CGImageDestinationFinalize(imageDestination) else {
            throw HEICError.couldNotFinalize
        }
        
        return data as Data
    }
}
