//
//  Date+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 13.06.2022.
//

import Foundation

extension Date {
    func dateFormatter(date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let formattedDate = dateFormatter.date(from: date)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: formattedDate!, relativeTo: Date.now)
    }
}
