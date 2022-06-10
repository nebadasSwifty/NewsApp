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
    
    func fetch(from category: Category, page: Int, query: String, completion: @escaping ([Article]) -> Void) {
        let urlString = generateNewsURL(from: category) + "&page=\(page)" + "&pageSize=100" + "&q=\(query)"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let dataResponse = try JSONDecoder().decode(NewsApiResonse.self, from: data)
                DispatchQueue.global().async {
                    completion(dataResponse.articles)
                }
            } catch {
                print(String(describing: error))
            }
        }.resume()
    }
    
    private func generateNewsURL(from category: Category) -> String {
        var url = baseUrlString
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return url
    }
    
    
}
