//
//  NewsViewModelType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit
import CoreData

protocol NewsViewModelType {
    func numberRows() -> Int
    func getArticle(for indexPath: IndexPath) -> ArticleObject
    func getData(completion: @escaping () -> Void)
}
