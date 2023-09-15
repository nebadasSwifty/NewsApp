//
//  Router.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

class Router: Routable {
    fileprivate weak var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        rootController?.pushViewController(viewController, animated: animated)
    }
    
    func popController(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    func setRootModule(_ viewController: UIViewController, animated: Bool) {
        rootController?.setViewControllers([viewController], animated: animated)
    }
}
