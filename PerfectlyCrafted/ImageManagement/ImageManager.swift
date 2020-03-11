//
//  ImageManager.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// Manages loading and saving of images from the disk or cache.
final class LocalImageManager {
    
    private let localImageLoader = LocalImageLoader()
    private let directory: URL
    private let fileManager = FileManager.default
    private let cache: NSCache<NSUUID, UIImage>
    
    /// The shared cache instance which will be used as default to ensure all images are stored in the same cache.
    static let sharedCache = NSCache<NSUUID, UIImage>()
    
    /// Creates a new `LocalImageManager` and its corresponding storage directory on disk.
    ///
    /// - Parameter directory: A `URL` that represents a directory of where the persister should save and retrieve objects from. If the directory does not exist, it will be created on initalization.
    /// - Parameter cache: The cached used to store images.
    /// - Throws: An `Error` in the process of creating the directory at the provided `URL`.
    init(directory: URL = FileManager.localImageDirectory, cache: NSCache<NSUUID, UIImage> = LocalImageManager.sharedCache) throws {
        if !fileManager.fileExists(atPath: directory.path) {
            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        }
        
        self.directory = directory
        self.cache = cache
    }
    
    /// Loads an image from the specified file URL if it is in the cache.
    ///
    /// - key: The identifier to use as a file name.
    /// - Returns: An optional image if it exists in the cache
    func cachedImage(forKey key: UUID) -> UIImage? {
        return cache.object(forKey: key as NSUUID)
    }
    
    /// Loads an image from the specified file URL. It will first check the cache and return the image from there if available. If the image is not in the cache it will load it from the disk.
    ///
    /// - Parameters:
    ///   - key: The identifier to use as a file name.
    ///   - completion: The completion handler called with the success or failure result of the image load.
    func loadImage(forKey key: UUID, completion: @escaping LocalImageLoader.ImageLoadCompletion) {
        if let cachedImage = cachedImage(forKey: key) {
            completion(.success(cachedImage))
            return
        }
        
        let fileURL = self.fileURL(forKey: key)
        localImageLoader.loadImage(fromFileURL: fileURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.cache.setObject(image, forKey: key as NSUUID)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Saves the image to the disk and provides a file url for its location.
    ///
    /// - Parameters:
    ///   - image: The image to be saved.
    ///   - key: The identifier to use as a file name.
    /// - Returns: An optional file url for where the image was saved if successful.
    func saveImage(_ image: UIImage, key: UUID) {
        
        do {
            let heicData = try image.heicData()
            let imageURL = fileURL(forKey: key)
            
            try heicData.write(to: imageURL)
            cache.setObject(image, forKey: key as NSUUID)
        } catch {
            assertionFailure("Failed to save image due to error: \(error).")
        }
    }
    
    /// Removes the image from the cache and disk.
    ///
    /// - Parameter key: The identifier to use as a file name.
    func removeImage(for key: UUID) {
        let imageURL = fileURL(forKey: key)
        do {
            try fileManager.removeItem(at: imageURL)
            cache.removeObject(forKey: key as NSUUID)
        } catch let error as NSError where error.domain == NSCocoaErrorDomain && error.code == NSFileNoSuchFileError {
            // The file didn't exist, so we can't delete it. For this operation, not an error, so just ignore it.
        } catch {
            assertionFailure("Failed to remove image due to error: \(error).")
        }
    }
    
    private func fileURL(forKey key: UUID) -> URL {
        return directory.appendingPathComponent("\(key.uuidString).heic")
    }
}

fileprivate extension FileManager {
    
    // It is expect that you can always get the application support directory.
    private static var applicationSupportDirectory: URL! { // swiftlint:disable:this implicitly_unwrapped_optional
        return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
    }
    
    static var localImageDirectory: URL {
        return applicationSupportDirectory.appendingPathComponent("Images")
    }
}
