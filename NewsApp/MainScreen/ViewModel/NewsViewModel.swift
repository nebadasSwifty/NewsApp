//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

class NewsViewModel: NewsViewModelType {
    var articles: [Article] = []
    var selectedCategory: Category
    var status: String = String()
    let networkService: NetworkServiceType
    
    
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
            self.articles.append(contentsOf: article)
            completion()
        }
    }
}
