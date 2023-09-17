//
//  NewsViewTests.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import XCTest
@testable import NewsApp

final class NewsViewTests: XCTestCase {
    var newsTableViewController: NewsTableViewController!

    override func setUpWithError() throws {
        newsTableViewController = NewsModuleBuilder.build()
        newsTableViewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        newsTableViewController = nil
    }

    func testHasATableView() throws {
        XCTAssertNotNil(newsTableViewController.tableView)
    }
    
    func testTableViewHasDelegate() throws {
        XCTAssertNotNil(newsTableViewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() throws {
        XCTAssertTrue(newsTableViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(newsTableViewController.responds(to: #selector(newsTableViewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() throws {
        XCTAssertNotNil(newsTableViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() throws {
        
        XCTAssertTrue(newsTableViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(newsTableViewController.responds(to: #selector(newsTableViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(newsTableViewController.responds(to: #selector(newsTableViewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() throws {
        let cell = newsTableViewController.tableView(newsTableViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "Cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
