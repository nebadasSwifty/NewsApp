//
//  NewsModuleBuilder.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

final class NewsModuleBuilder {
    static func build() -> NewsTableViewController {
        let networkService = NetworkService()
        let viewModel = NewsViewModel(networkService: networkService)
        let newsVC = NewsTableViewController(viewModel: viewModel)
        return newsVC
    }
}
