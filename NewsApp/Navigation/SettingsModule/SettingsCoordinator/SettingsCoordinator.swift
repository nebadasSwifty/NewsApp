//
//  SettingsCoordinator.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

protocol SettingsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

class SettingsCoordinator: Coordinator, SettingsCoordinatorOutput {
    var finishFlow: CompletionBlock?
    
    override func start() {
        performFlow()
    }
    
    private func performFlow() {
        let settingsVC = SettingsModuleBuilder.build()
        settingsVC.finishFlow = {
            self.finishFlow?()
        }
        router.push(settingsVC, animated: true)
    }
}
