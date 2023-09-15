//
//  NetworkService.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//


import UIKit
import CoreData

typealias CompletionHandlerWithApiResponseResult = ((Result<NewsApiResponse?, NetworkError>) -> Void)

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetch(from category: Category, completionHandler: @escaping CompletionHandlerWithApiResponseResult) {
        guard let url = generateNewsURL(from: category) else {
            completionHandler(.failure(.incorrectURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(.requestWithError))
            }
            
            guard let data = data else {
                completionHandler(.failure(.incorrectData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsApiResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(.success(result))
                }
            } catch {
                completionHandler(.failure(.couldntParseData))
            }
        }.resume()
    }
    
    private func generateNewsURL(from category: Category) -> URL? {
        let query = (UserDefaults.standard.object(forKey: "query") as? [String] ?? [""]).joined(separator: "+")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: Constant.apiKey),
            URLQueryItem(name: "pageSize", value: "100"),
            URLQueryItem(name: "language", value: "ru"),
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "q", value: query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)),
            URLQueryItem(name: "page", value: "1")
        ]
        
        return components.url
    }
    
}
