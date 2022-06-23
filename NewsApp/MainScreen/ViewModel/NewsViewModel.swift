//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import CoreData

final class NewsViewModel: NewsViewModelType {
    //MARK: - CoreData
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
    private let sortByDateDescriptor: NSSortDescriptor = NSSortDescriptor(key: #keyPath(ArticleEntity.publishedAt), ascending: false)
    //MARK: - Table view data source functions
    private var articles: [ArticleEntity] = []
    lazy var selectedCategory: Category = {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories") else { return Category.general }
        let selectCategory = Category(rawValue: savedCategory)
        return selectCategory ?? .general
    }()
    lazy var query: String = getQuery()
    let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

extension NewsViewModel {
    func numberRows() -> Int {
        return articles.count
    }
    private func fetchingData(completion: @escaping ([ArticleEntity]?) -> Void) {
        query = getQuery()
        networkService.fetch(from: selectedCategory, page: 1, query: query)
        fetchRequest.sortDescriptors = [sortByDateDescriptor]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            do {
                let result = try self.container?.viewContext.fetch(self.fetchRequest)
                completion(result)
            } catch let error as NSError {
                print("Could not fetch: \(error)")
            }
        }
    }
    
    func getData(completion: @escaping () -> Void) {
        self.fetchingData { article in
            guard let article = article else { return }
            self.articles = article
            completion()
        }
    }
    
    func getArticle(for indexPath: IndexPath) -> ArticleEntity {
        return articles[indexPath.row]
    }
    
    private func getQuery() -> String {
        let queryFetch = UserDefaults.standard.object(forKey: "query") as? [String] ?? [""]
        var result = ""
        queryFetch.forEach { result += "+\($0)" }
        return result
    }
    
    private func getCategory() -> Category {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories") else { return Category.general }
        let selectCategory = Category(rawValue: savedCategory)
        return selectCategory ?? .general
    }
    
}

