//
//  SettingsViewModelTests.swift
//  NewsAppTests
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import XCTest
@testable import NewsApp

final class SettingsViewModelTests: XCTestCase {
    var viewModel: SettingsViewModelType!
    var userKeysSaver: UserKeysProtocol!

    override func setUpWithError() throws {
        userKeysSaver = UserKeysSaver()
        userKeysSaver.setKey(key: "testQuery")
        viewModel = SettingsViewModel(userKeysSaver: userKeysSaver)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        userKeysSaver = nil
    }
    
    func testSuccessSavingArray() throws {
        let query = ["foo", "baz", "bar"]
        viewModel.savedNewsArray = query
        XCTAssertEqual(viewModel.savedNewsArray, query)
    }
    
    func testSuccessGetNumbersOfRows() throws {
        let query = ["foo", "baz", "bar"]
        viewModel.savedNewsArray = query
        XCTAssert(viewModel.numberRows() == query.count)
    }
    
    func testNotNilSettingsCoordinator() throws {
        let settingsCoordinator = CoordinatorFactory().makeSettingsCoordinator(router: Router(rootController: UINavigationController()))
        settingsCoordinator.start()
        XCTAssertNotNil(settingsCoordinator)
    }
}
