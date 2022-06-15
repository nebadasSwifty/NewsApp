//
//  NetworkService.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation


final class NetworkService: NetworkServiceType {
    private var baseUrlString = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "acc6674fc31b4761ab96d2b7be96a93d"
    private let session = URLSession.shared
    
    func fetch(from category: Category, page: Int, query: String) {
        guard let url = generateNewsURL(from: category, query: query, page: page) else { return }
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            UserDefaults.standard.set(data, forKey: "articles")
            
        }.resume()
    }
    
    private func generateNewsURL(from category: Category, query: String, page: Int) -> URL? {
        var url = baseUrlString
        url += "apiKey=\(apiKey)"
        url += "&pageSize=100"
        url += "&language=ru"
        url += "&category=\(category.rawValue)"
        url += "&q=\(query)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed) ?? ""
        url += "&page=\(page)"
        return URL(string: url)
    }
    
}
