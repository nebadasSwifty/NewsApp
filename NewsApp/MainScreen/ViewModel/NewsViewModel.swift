//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import CoreData

final class NewsViewModel: NewsViewModelType {
    //MARK: - Table view data source functions
    private var articles: [ArticleObject] = []
    private var networkService: NetworkServiceType
    var selectedCategory: Category {
        return getSelectedCategory()
    }
    
    var query: String {
        return getQuery()
    }
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    private func getSelectedCategory() -> Category {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories"),
              let selectedCategory = Category(rawValue: savedCategory) else {
            return Category.general
        }
        
        return selectedCategory
    }
    
    func numberRows() -> Int {
        return articles.count
    }
    
    func getData(completion: @escaping () -> Void) {
        NSManagedObject.deleteEntity("ArticleObject")
        
        networkService.terminationHandler = { [weak self] in
            if let self = self {
                let sortDescriptior = [NSSortDescriptor(key: #keyPath(ArticleObject.publishedAt), ascending: false)]
                NSManagedObject.fetchAll("ArticleObject", sortDescriptors: sortDescriptior, list: &self.articles)
                completion()
            }
        }
        networkService.fetch(from: selectedCategory, query: query)
    }
    
    func getArticle(for indexPath: IndexPath) -> ArticleObject {
        return articles[indexPath.row]
    }
    
    private func getQuery() -> String {
        let queryFetch = UserDefaults.standard.object(forKey: "query") as? [String] ?? [""]
        return queryFetch.joined(separator: "+")
    }
}
