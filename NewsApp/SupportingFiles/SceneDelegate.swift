//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootController: UINavigationController {
        return window?.rootViewController as! UINavigationController
    }
    fileprivate lazy var coordinator: Coordinatable = makeCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UINavigationController()
            window?.makeKeyAndVisible()
        }
    }
}

private extension SceneDelegate {
    func makeCoordinator() -> Coordinatable {
        return AppCoordinator(router: Router(rootController: rootController))
    }
}

