//
//  NewsCellViewModelType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

protocol NewsCellViewModelType {
    var title: String { get }
    var description: String { get }
    var source: String { get }
    var datePublished: String { get }
    var newsImage: URL? { get }
}
