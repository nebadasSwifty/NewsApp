//
//  SettingsViewTests.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import XCTest
@testable import NewsApp

final class SettingsViewTests: XCTestCase {
    var settingsViewController: SettingsViewController!
    
    override func setUpWithError() throws {
        settingsViewController = SettingsModuleBuilder.build()
        settingsViewController.viewDidLoad()
        settingsViewController.viewModel.savedNewsArray = ["foo"]
    }

    override func tearDownWithError() throws {
        settingsViewController = nil
    }

    func testHasATableView() throws {
        XCTAssertNotNil(settingsViewController.tableView)
    }
    
    func testTableViewHasDelegate() throws {
        XCTAssertNotNil(settingsViewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() throws {
        XCTAssertTrue(settingsViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() throws {
        XCTAssertNotNil(settingsViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() throws {
        XCTAssertTrue(settingsViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(settingsViewController.responds(to: #selector(settingsViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(settingsViewController.responds(to: #selector(settingsViewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() throws {
        let cell = settingsViewController.tableView(settingsViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "Cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableViewRepondsOnTrailingAction() throws {
        XCTAssertTrue(settingsViewController.responds(to: #selector(settingsViewController.tableView(_:trailingSwipeActionsConfigurationForRowAt:))))
    }
}
