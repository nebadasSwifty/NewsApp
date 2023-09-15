//
//  Coordinator.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

class Coordinator: Coordinatable {
    var childCoordinators: [Coordinatable] = []
    var router: Routable
    
    func start() {}
    
    init(router: Routable) {
        self.router = router
    }
    
    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

