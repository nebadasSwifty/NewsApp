//
//  NewsCoordinator.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

protocol NewsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

class NewsCoordinator: Coordinator, NewsCoordinatorOutput {
    var finishFlow: CompletionBlock?
    
    override func start() {
        performFlow()
    }
    
    private func performFlow() {
        let newsView = NewsModuleBuilder.build()
        newsView.finishFlow = {
            self.finishFlow?()
        }
        router.setRootModule(newsView, animated: true)
    }
}
