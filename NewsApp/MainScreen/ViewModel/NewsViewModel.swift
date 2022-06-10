//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

final class NewsViewModel: NewsViewModelType {
    var articles: [Article] = []
    var selectedCategory: Category
    var status: String = String()
    let networkService: NetworkServiceType
    let categoriesArray: [String] = Category.allCases.map { $0.rawValue }
    
    
    init(networkService: NetworkServiceType, selectedCategory: Category = .general) {
        self.networkService = networkService
        self.selectedCategory = selectedCategory
    }
}

extension NewsViewModel {
    func numberRows() -> Int {
        return articles.count
    }
    func fetchingData(page: Int, completion: @escaping () -> Void) {
        networkService.fetch(from: selectedCategory, page: page) { article in
            self.articles = article
            completion()
        }
    }
}
