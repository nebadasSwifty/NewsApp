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
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
