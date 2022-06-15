//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation


final class NewsViewModel: NewsViewModelType {
    private var articles: [Article] = []
    var selectedCategory: Category = {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories") else { return Category.general }
        let selectCategory = Category(rawValue: savedCategory)
        return selectCategory ?? .general
    }()
    var query: String = {
        let query = UserDefaults.standard.object(forKey: "query") as? [String] ?? [String]()
        var result = ""
        query.forEach { result += "+\($0)" }
        return result
    }()
    
    let networkService: NetworkServiceType
    
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

extension NewsViewModel {
    func numberRows() -> Int {
        return articles.count
    }
    func fetchingData(completion: @escaping ([Article]) -> Void) {
        networkService.fetch(from: selectedCategory, page: 1, query: query)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let data = UserDefaults.standard.data(forKey: "articles") else { return }
            if let decodedData = try? JSONDecoder().decode(NewsApiResonse.self, from: data) {
                completion(decodedData.articles)
            }
        }
    }
    
    func getData(completion: @escaping () -> Void) {
        self.fetchingData { article in
            self.articles = article
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getArticle(for indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
}

