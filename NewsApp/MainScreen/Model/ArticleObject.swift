//
//  ArticleObject.swift
//  NewsApp
//
//  Created by Кирилл on 19.09.2022.
//

import CoreData

class ArticleObject: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var content: String?
    @NSManaged var newsDescription: String?
    @NSManaged var publishedAt: Date?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    
    func parse(article: Article) {
        author = article.author
        content = article.content
        title = article.title
        newsDescription = article.newsDescription
        publishedAt = Date().dateFromString(string: article.publishedAt ?? "")
        url = article.url
        urlToImage = article.urlToImage
    }
}
