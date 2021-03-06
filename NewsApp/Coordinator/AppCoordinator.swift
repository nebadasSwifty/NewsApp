//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

class AppCoordinator: AppCoordinatorType {
    var navigationContoller: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationContoller = navigationController
    }
    
    func start() {
        let newsVC = NewsTableViewController()
        let networkSevice = NetworkService()
        let viewModel = NewsViewModel(networkService: networkSevice)
        newsVC.networkService = networkSevice
        newsVC.viewModel = viewModel
        newsVC.coordinator = self
        navigationContoller.navigationBar.prefersLargeTitles = true
        navigationContoller.pushViewController(newsVC, animated: true)
    }
    
    func showSettings() {
        let settingsVC = SettingsViewController()
        let viewModel = SettingsViewModel()
        settingsVC.viewModel = viewModel
        navigationContoller.pushViewController(settingsVC, animated: true)
    }
    
}
