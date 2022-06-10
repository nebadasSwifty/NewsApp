//
//  AppCoordinatorType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

protocol AppCoordinatorType {
    var navigationContoller: UINavigationController { get }
    func start()
    func showSettings()
}
