//
//  Date+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 13.06.2022.
//

import Foundation

extension Date {
    static func dateFromString(string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: string)
    }
    
    static func dateFormatter(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
