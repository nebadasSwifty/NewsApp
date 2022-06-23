//
//  NetworkService.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation
import UIKit


final class NetworkService: NetworkServiceType {
    private var baseUrlString = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "c0e24dfff73b48fb8db9d7509293d932"
    private let session = URLSession.shared
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func fetch(from category: Category, page: Int, query: String) {
        guard let url = generateNewsURL(from: category, query: query, page: page) else { return }
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(NewsApiResonse.self, from: data).articles
                DispatchQueue.main.async {
                    NewsCoreData.sharedInstance.saveDataOf(articles: decodedData)
                }
            } catch let error as NSError {
                print("Could not fetch data from api: \(error)")
            }
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
