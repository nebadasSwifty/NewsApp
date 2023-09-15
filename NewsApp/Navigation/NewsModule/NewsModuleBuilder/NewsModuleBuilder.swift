//
//  NewsModuleBuilder.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

final class NewsModuleBuilder {
    static func build() -> NewsTableViewController {
        let newsVC = NewsTableViewController()
        let viewModel = NewsViewModel()
        newsVC.viewModel = viewModel
        return newsVC
    }
}
