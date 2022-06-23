//
//  NewsModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation


// MARK: - News
struct NewsApiResonse: Codable {
    let status: String
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String?
    let newsDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case newsDescription = "description"
        case author, title, url, urlToImage, publishedAt, content
    }
}
