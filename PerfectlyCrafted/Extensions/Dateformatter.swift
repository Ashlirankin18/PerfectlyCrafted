//
//  Dateformatter.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/9/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// A static instance of date formatter.
    static let postDateFormatter: DateFormatter = DateFormatter()
    
    /// Formats a given date.
    /// - Parameter date: The date the post was created.
    static func format(date: Date) -> String? {
        postDateFormatter.dateStyle = .long
        return postDateFormatter.string(from: date)
    }
}
