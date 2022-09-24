//
//  Category.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

enum Category: String, CaseIterable {
    case general = "General"
    case business = "Business"
    case technology = "Technology"
    case entertainment = "Entertainment"
    case sports = "Sports"
    case science = "Science"
    case health = "Health"
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

