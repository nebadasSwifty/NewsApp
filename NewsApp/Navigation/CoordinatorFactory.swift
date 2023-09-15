//
//  CoordinatorFactory.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import Foundation

class CoordinatorFactory {
    func makeNewsCoordinator(router: Routable) -> Coordinatable & NewsCoordinatorOutput {
        return NewsCoordinator(router: router)
    }
    
    func makeSettingsCoordinator(router: Routable) -> Coordinatable & SettingsCoordinatorOutput {
        return SettingsCoordinator(router: router)
    }
}
