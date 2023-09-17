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
    func fetchData(category: Category)
    func getArticle(for indexPath: IndexPath) -> ArticleObject?
}


final class NewsViewModel: NewsViewModelType {
    //MARK: - Table view data source functions
    let articles: Dynamic<[ArticleObject]> = .init([])
    let errorString: Dynamic<String> = .init("")
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return articles.value.count
    }
    
    func fetchData(category: Category) {
        NSManagedObject.deleteEntity(Entity.article)
        networkService.fetch(from: category) { [weak self] result in
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
        if articles.value.indices.contains(indexPath.row) {
            return articles.value[indexPath.row]
        }
        
        return nil
    }
}
