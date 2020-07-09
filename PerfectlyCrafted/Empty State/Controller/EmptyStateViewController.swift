//
//  EmptyStateViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/13/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UIViewController` subclass which displays the empty state view.
final class EmptyStateViewController: UIViewController {

    @IBOutlet private weak var primaryTextLabel: UILabel!
    
    @IBOutlet private weak var secondaryTextLabel: UILabel!
    
    private let primaryText: String
    private let secondaryText: String
    
    /// Called when the add entry button is tapped.
    var addEntryButtonTapped: (() -> Void)?
    
    /// Creates a new instance of `EmptyStateViewController`.
    /// - Parameters:
    ///   - primaryText: The primary text.
    ///   - secondaryText: The secondary text.
    init(primaryText: String, secondaryText: String) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        super.init(nibName: "EmptyStateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryTextLabel.text = primaryText
        secondaryTextLabel.text = secondaryText
    }
    
    @IBAction private func newItemButtonTapped(_ sender: UIButton) {
        addEntryButtonTapped?()
    }
}
