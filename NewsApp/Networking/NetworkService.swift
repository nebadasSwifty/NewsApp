//
//  NetworkService.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//


import UIKit
import CoreData

struct NetworkService: NetworkServiceType {
    private var baseUrlString = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "c0e24dfff73b48fb8db9d7509293d932"
    internal var terminationHandler: (() -> ())? = nil
    
    func fetch(from category: Category, query: String) {
        guard let url = generateNewsURL(from: category, query: query) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            OperationQueue.main.addOperation {
                do {
                    let decodedArticles = try JSONDecoder().decode(NewsApiResonse.self, from: data).articles
                    decodedArticles.forEach({ article in
                        if let entity = NSEntityDescription.insertNewObject(forEntityName: "ArticleObject", into: AppDelegate.context) as? ArticleObject {
                            entity.parse(article: article)
                        }
                    })
                    
                    terminationHandler?()
                } catch let error as NSError {
                    print("Could not decode data from api: \(error)")
                }
            }
        }.resume()
        
    }
    
    private func generateNewsURL(from category: Category, query: String) -> URL? {
        var url = baseUrlString
        url += "apiKey=\(apiKey)"
        url += "&pageSize=100"
        url += "&language=ru"
        url += "&category=\(category.rawValue)"
        url += "&q=\(query)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed) ?? ""
        url += "&page=1"
        return URL(string: url)
    }
    
}
