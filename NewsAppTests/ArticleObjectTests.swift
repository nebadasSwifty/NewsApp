//
//  ArticleObjectTests.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import XCTest
import CoreData
@testable import NewsApp

final class ArticleObjectTests: XCTestCase {
    var article: Article!

    override func setUpWithError() throws {
        article = Article(author: "Foo", title: "Baz", description: "Bar", url: "", urlToImage: "", publishedAt: "", content: "")
    }

    override func tearDownWithError() throws {
        article = nil
    }

    func testSuccessParsingElement() throws {
        let articleObject: ArticleObject?
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entity.article, into: DatabaseService.shared.context) as? ArticleObject {
             articleObject = entity.parse(article)
        } else {
            articleObject = nil
        }
        
        XCTAssertNotNil(articleObject?.author)
    }
    
    func testFailureParsingElement() throws {
        let articleObject: ArticleObject?
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entity.article, into: DatabaseService.shared.context) as? ArticleObject {
             articleObject = entity.parse(nil)
        } else {
            articleObject = nil
        }
        
        XCTAssertNil(articleObject?.author)
    }
}
