//
//  NewsViewModelTests.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import XCTest
@testable import NewsApp

final class NewsViewModelTests: XCTestCase {
    var viewModel: NewsViewModelType!
    var mockNetworkService: NetworkServiceProtocol!

    override func setUpWithError() throws {
        mockNetworkService = MockNetwork()
        viewModel = NewsViewModel(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkService = nil
    }

    func testSuccessArticleParsing() throws {
        viewModel.fetchData(category: .general)
        XCTAssertTrue(!viewModel.articles.value.isEmpty)
    }
    
    func testFailureArticleParsing() throws {
        viewModel.fetchData(category: .business)
        XCTAssertTrue(!viewModel.errorString.value.isEmpty)
    }
    
    func testSuccessGetArticle() throws {
        viewModel.fetchData(category: .general)
        let article = viewModel.getArticle(for: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(article)
    }
    
    func testFailureGetArticle() throws {
        viewModel.fetchData(category: .business)
        let article = viewModel.getArticle(for: IndexPath(row: 0, section: 0))
        
        XCTAssertNil(article)
    }
    
    func testSuccessNumberOfRows() throws {
        viewModel.fetchData(category: .general)
        let numberOfRows = viewModel.numberOfRowsInSection(0)
        XCTAssert(numberOfRows != 0)
    }
    
    func testFailureNumberOfRows() throws {
        viewModel.fetchData(category: .business)
        let numberOfRows = viewModel.numberOfRowsInSection(0)
        XCTAssert(numberOfRows == 0)
    }
    
    func testNilFetchData() throws {
        viewModel.fetchData(category: .entertainment)
        
        XCTAssert(viewModel.articles.value.isEmpty)
    }
    
    func testCategoryTest() throws {
        let category = Category.general.text
        
        XCTAssertNotNil(category)
    }
}
