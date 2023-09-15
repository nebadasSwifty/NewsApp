//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

typealias CompletionBlock = (() -> Void)

class AppCoordinator: Coordinator {
    override func start() {
        performNewsFlow()
    }
    
    func performNewsFlow() {
        let newsCoordinator = CoordinatorFactory().makeNewsCoordinator(router: router)
        newsCoordinator.finishFlow = {
            self.performSettingsFlow()
            self.removeDependency(newsCoordinator)
        }
        addDependency(newsCoordinator)
        newsCoordinator.start()
    }
    
    func performSettingsFlow() {
        let settingsCoordinator = CoordinatorFactory().makeSettingsCoordinator(router: router)
        settingsCoordinator.finishFlow = {
            self.performNewsFlow()
            self.removeDependency(settingsCoordinator)
        }
        addDependency(settingsCoordinator)
        settingsCoordinator.start()
    }
}
