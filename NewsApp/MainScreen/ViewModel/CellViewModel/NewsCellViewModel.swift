//
//  NewsCellViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

class NewsCellViewModel: NewsCellViewModelType {
    var title: String
    var description: String
    var source: String
    var datePublished: String
    var newsImage: URL?
    
    init(title: String, description: String, source: String, datePublished: String, newsImage: URL?) {
        self.title = title
        self.description = description
        self.source = source
        self.datePublished = datePublished
        self.newsImage = newsImage
    }
    
}
