//
//  SnapshotRenderer.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/19/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class SnapshotRenderer {
    
    private let view: UIView
    
    /// Creates a new instance of `SnapshotRenderer`.
    /// - Parameter view: The view to be render as an image.
    init(view: UIView) {
        self.view = view
    }
    
    private func renderSnapshot(scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Uses the rendered image Data and stores it as a URL.
    /// - Returns: The URL contain the address of the rendered image.
    func snapshotURL() -> URL? {
        if let data = renderSnapshot(scale: 2.0).pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("PerfectlyCrafted.png")
            do {
                try data.write(to: filename)
            } catch {
                print(error)
            }
            return filename
        } else {
            return nil
        }
    }
}
