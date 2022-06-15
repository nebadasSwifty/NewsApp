//
//  NewsViewModelType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

protocol NewsViewModelType {
    func numberRows() -> Int
    func getArticle(for indexPath: IndexPath) -> Article
    var selectedCategory: Category { get set }
    func getData(completion: @escaping () -> Void)
    var query: String { get set }
}
