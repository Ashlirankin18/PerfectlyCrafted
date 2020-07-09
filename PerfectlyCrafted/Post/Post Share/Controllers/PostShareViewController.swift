//
//  PostShareViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/19/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UIViewController` subclass which contains the view to be rendered as an image.
final class PostShareViewController: UIViewController {
    
    @IBOutlet private weak var postShareView: PostShareView!
    
    private let post: Post
    
    private let imageLoader = try? LocalImageManager()
    
    /// Creates a new instance `PostShareViewController`.
    /// - Parameter post: The post that will be shared.
    init(post: Post) {
        self.post = post
        super.init(nibName: "PostShareViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = post.photoIdentfier {
            imageLoader?.loadImage(forKey: id, completion: { [weak self] (result) in
                switch result {
                case let .success(image):
                    self?.postShareView.viewModel = PostShareView.ViewModel(image: image, postTitle: self?.post.title?.capitalized ?? "Title here", date: Date(), description: self?.post.postDescription?.capitalized ?? "Life is what you make it.")
                case .failure:
                    self?.postShareView.viewModel = nil
                }
            })
        } else {
            postShareView.viewModel = nil
        }
        title = post.title?.capitalized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let snapshotRenderer = SnapshotRenderer(view: postShareView)
        if let url = snapshotRenderer.snapshotURL() {
            let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(activityController, animated: true)
        }
    }
}
