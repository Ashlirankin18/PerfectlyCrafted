//
//  EmptyStateViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/13/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class EmptyStateViewController: UIViewController {

    @IBOutlet private weak var primaryTextLabel: UILabel!
    
    @IBOutlet private weak var secondaryTextLabel: UILabel!
    
    private let primaryText: String
    private let secondaryText: String
    
    var addEntryButtonTapped: (() -> Void)?
    
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
