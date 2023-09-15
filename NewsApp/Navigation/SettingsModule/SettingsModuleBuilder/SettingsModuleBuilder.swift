//
//  SettingsModuleBuilder.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import Foundation

class SettingsModuleBuilder {
    static func build() -> SettingsViewController {
        let settingsVC = SettingsViewController()
        let viewModel = SettingsViewModel()
        settingsVC.viewModel = viewModel
        return settingsVC
    }
}
