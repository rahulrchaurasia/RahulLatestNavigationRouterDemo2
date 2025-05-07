//
//  DateFormatterHelper.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import Foundation


import Foundation

struct DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    func format(date: Date) -> String {
        return displayDateFormatter.string(from: date)
    }
}
