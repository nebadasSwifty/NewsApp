//
//  NewsViewModelType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

protocol NewsViewModelType {
    var articles: [Article] { get set }
    func numberRows() -> Int
    var selectedCategory: Category { get set }
    func fetchingData(page: Int, completion: @escaping () -> Void)
}
