//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import CoreData

final class NewsViewModel {
    //MARK: - Table view data source functions
    let articles: Dynamic<[ArticleObject]> = .init([])
    let errorString: Dynamic<String> = .init("")
    var selectedCategory: Category {
        guard let savedCategory = UserDefaults.standard.string(forKey: "categories"),
              let category = Category(rawValue: savedCategory) else {
            return Category.general
        }
        
        return category
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return articles.value.count
    }
    
    func getData() {
        NSManagedObject.deleteEntity("ArticleObject")
        NetworkService.shared.fetch(from: selectedCategory) { [weak self] result in
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
