//
//  LocalImageLaoder.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// Loads images from local file URLs.
final class LocalImageLoader {
    
    /// Signature of the completion handler called upon success or failure to load an image.
    ///
    /// - Parameter result: The success or failure result of the image load.
    typealias ImageLoadCompletion = (_ result: Result<UIImage, Error>) -> Void

    /// Potential errors that can occur when attempting to load an image with `LocalImageLoader`.
    enum Error: Swift.Error {
        
        /// The url specified is not a file URL.
        case specifiedURLIsNotAFileURL
        
        /// The file at the specified URL could not be located.
        case fileNotFound
        
        /// The data at the specified URL was unable to be read as an image.
        case unableToReadImage
    }
    
    private let fileManager = FileManager.default
    
    private let loadImageOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "net.ashli.LocalImageLoaderQueue"
        return queue
    }()
    
    /// Loads an image from the specified file URL.
    ///
    /// - Parameters:
    ///   - fileURL: The file URL of the image on disk.
    ///   - completionQueue: The operation queue on which the completion handler will be called.
    ///   - completion: The completion handler called with the success or failure result of the image load.
    func loadImage(fromFileURL fileURL: URL, completionQueue: OperationQueue = .main, completion: @escaping ImageLoadCompletion) {
        let fileManager = self.fileManager
        
        func runCompletion(with result: Result<UIImage, Error>) {
            completionQueue.addOperation {
                completion(result)
            }
        }
        
        guard fileURL.isFileURL else {
            assertionFailure("`fileURL` must be a file url")
            runCompletion(with: .failure(Error.specifiedURLIsNotAFileURL))
            return
        }
        
        loadImageOperationQueue.addOperation {
            
            let filePath = fileURL.path
            
            guard fileManager.fileExists(atPath: filePath) else {
                runCompletion(with: .failure(Error.fileNotFound))
                return
            }
            
            guard let image = UIImage(contentsOfFile: filePath) else {
                runCompletion(with: .failure(Error.unableToReadImage))
                return
            }
            
            runCompletion(with: .success(image))
        }
    }
}
