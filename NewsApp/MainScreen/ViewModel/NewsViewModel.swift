//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

final class NewsViewModel: NewsViewModelType {
    private var articles: [Article] = []
    var selectedCategory: Category
    var query: String = {
        let query = UserDefaults.standard.object(forKey: "query") as? [String] ?? [String]()
        var result = ""
        query.forEach { result += "+\($0)" }
        return result
    }()
    
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
    func fetchingData(page: Int, query: String, completion: @escaping () -> Void) {
        networkService.fetch(from: selectedCategory, page: page, query: query) { article in
            self.articles = article
            completion()
        }
    }
    func getArticle(for indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
}
