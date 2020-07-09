//
//  DetailedDescriptionViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/5/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

/// Subscribe to this object if you would like to receive notifications about the status of the pan gesture recognizer.
protocol DetailedDescriptionViewControllerDelegate: AnyObject {
    
    /// Called when a pan gesture has begun.
    /// - Parameter cardViewController: `CardPresentationController` displays detils about an attraction.
    func panGestureDidBegin(_ cardViewController: DetailedDescriptionViewController)
    
    /// Called when a pan gesture has changed
    /// - Parameters:
    ///   - cardViewController: `CardPresentationController` displays detils about an attraction.
    ///   - translation: The translation of the pan gesture in the coordinate system of the specified view.
    func panGestureDidChange(_ cardViewController: DetailedDescriptionViewController, with translation: CGPoint)
    
    /// Called when a pan gesture has ended
    /// - Parameter cardViewController: `CardPresentationController` displays detils about an attraction.
    func panGestureDidEnd(_ cardViewController: DetailedDescriptionViewController)
}

/// `UIViewController` subclass which displays the post description.
final class DetailedDescriptionViewController: UIViewController {

    @IBOutlet private weak var handleAreaView: UIView!
    
    @IBOutlet private weak var postDescriptionTextView: UITextView!
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(handleCardPan(panGestureRecognizer:)))
    
    /// Notifies subscriber to pan gesture recognizer changes.
    weak var delegate: DetailedDescriptionViewControllerDelegate?
    
    /// The post description.
    var postDescription: String? {
        didSet {
            postDescriptionTextView.text = postDescription
        }
    }
    
    /// Creates a new instance of `DetailedDescriptionViewController`.
    /// - Parameter postDescription: The post description.
    init(postDescription: String?) {
        self.postDescription = postDescription
        super.init(nibName: "DetailedDescriptionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAreaView.isUserInteractionEnabled = true
        handleAreaView.addGestureRecognizer(panGestureRecognizer)
        postDescriptionTextView.text = postDescription
    }
    
    @objc private func handleCardPan(panGestureRecognizer: UIPanGestureRecognizer) {
        switch panGestureRecognizer.state {
        case .began:
            delegate?.panGestureDidBegin(self)
        case .changed:
            delegate?.panGestureDidChange(self, with: panGestureRecognizer.translation(in: handleAreaView))
        case .ended:
            delegate?.panGestureDidEnd(self)
        default:
            break
        }
    }
}
