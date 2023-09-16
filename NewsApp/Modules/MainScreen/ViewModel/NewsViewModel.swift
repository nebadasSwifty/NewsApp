//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import CoreData

protocol NewsViewModelType {
    var articles: Dynamic<[ArticleObject]> { get }
    var errorString: Dynamic<String> { get }
    
    func numberOfRowsInSection(_ section: Int) -> Int
    func fetchData()
    func getArticle(for indexPath: IndexPath) -> ArticleObject?
}


final class NewsViewModel: NewsViewModelType {
    //MARK: - Table view data source functions
    let articles: Dynamic<[ArticleObject]> = .init([])
    let errorString: Dynamic<String> = .init("")
    let networkService: NetworkServiceProtocol
    private var selectedCategory: Category {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories"),
              let category = Category(rawValue: savedCategory) else {
            return Category.general
        }
        
        return category
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return articles.value.count
    }
    
    func fetchData() {
        NSManagedObject.deleteEntity(Entity.article)
        networkService.fetch(from: selectedCategory) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                let articles: [ArticleObject] = DatabaseService.shared.parseToDatabase(with: newsResponse?.articles ?? [], for: Entity.article)
                self?.articles.value = articles
            case .failure(let error):
                self?.errorString.value = error.localizedDescription
            }
        }
    }
    
    func getArticle(for indexPath: IndexPath) -> ArticleObject? {
        return articles.value[indexPath.row]
    }
}
