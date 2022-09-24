//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinatorType?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController()
            coordinator = AppCoordinator(navigationController: navigationController)
            coordinator?.start()
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

