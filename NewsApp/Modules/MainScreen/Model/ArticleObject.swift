//
//  ArticleObject.swift
//  NewsApp
//
//  Created by Кирилл on 19.09.2022.
//

import CoreData

protocol Parsable: AnyObject {
    associatedtype Element
    func parse(_ element: Element?) -> Self?
}

final class ArticleObject: NSManagedObject, Parsable {
    typealias Element = Article
    
    @NSManaged var author: String?
    @NSManaged var content: String?
    @NSManaged var newsDescription: String?
    @NSManaged var publishedAt: Date?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    
    func parse(_ element: Article?) -> ArticleObject? {
        guard let element else { return nil }
        
        author = element.author
        content = element.content
        title = element.title
        newsDescription = element.description
        publishedAt = Date().dateFromString(string: element.publishedAt ?? "")
        url = element.url
        urlToImage = element.urlToImage
        
        return self
    }
}
