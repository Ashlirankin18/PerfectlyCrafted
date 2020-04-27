//
//  DatePickerViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/6/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class DatePickerViewController: UIViewController {
    
    @IBOutlet private weak var eventDatePicker: UIDatePicker!
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let button = CircularButton(image: .cancel)
        button.buttonTapped = { [weak self] _ in
            self?.dismiss(animated: true)
        }
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var confirmBarButtonItem: UIBarButtonItem = {
        let button = CircularButton(image: .confirm)
        button.buttonTapped = { [weak self] _ in
            self?.didSelectEventDate?(self?.eventDatePicker.date ?? Date())
            self?.dismiss(animated: true)
        }
        return UIBarButtonItem(customView: button)
    }()
    
    var didSelectEventDate: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Event Date"
        configureNavigationBar()
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = confirmBarButtonItem
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}
