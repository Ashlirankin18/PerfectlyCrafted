//
//  DatePickerTableViewCell.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
  
    struct ViewModel {
        
        var shouldHidePiker: Bool
        
        let date: Date
    }
    
    private var datePickerDateChanged: ((Date) -> Void)?

    @IBOutlet private weak var dateLabel: UILabel!
 
    private var selectedDate: Date?
    
    var saveButtonTapped: ((Date?) -> Void)?
    
    var viewModel: ViewModel? {
        didSet {
            dateLabel.text = DateFormatter.format(date: viewModel?.date ?? Date())
            entryDatePicker.date = viewModel?.date ?? Date()
        }
    }
    
    @IBOutlet private weak var entryDatePicker: UIDatePicker!
    
    @IBAction private func datePickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = DateFormatter.format(date: sender.date)
        selectedDate = sender.date
    }
}
