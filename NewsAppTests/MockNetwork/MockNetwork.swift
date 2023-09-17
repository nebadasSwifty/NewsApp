//
//  MockNetwork.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import Foundation
@testable import NewsApp

final class MockNetwork: NetworkServiceProtocol {
    let publishedAt = Date.dateFromString(string: "2020-07-10 15:00:00.000")
    func fetch(from category: NewsApp.Category, completionHandler: @escaping NewsApp.CompletionHandlerWithApiResponseResult) {
        if category == .general {
            completionHandler(.success(NewsApiResponse(status: "success",
                                                       articles: [Article(author: "Foo",
                                                                          title: "Bar",
                                                                          description: "Foo Bar",
                                                                          url: "Baz Bar",
                                                                          urlToImage: "Bar Foo",
                                                                          publishedAt: Date.dateFormatter(date: publishedAt ?? Date()),
                                                                          content: "Foo Baz Bar")])))
        } else if category == .entertainment {
            completionHandler(.success(nil))
        } else {
            completionHandler(.failure(.couldntParseData))
        }
    }
}
