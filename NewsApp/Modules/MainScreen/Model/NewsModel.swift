//
//  NewsModel.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

// MARK: - News
struct NewsApiResponse: Decodable {
    let status: String
    let articles: [Article]
}

// MARK: - Article
struct Article: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
