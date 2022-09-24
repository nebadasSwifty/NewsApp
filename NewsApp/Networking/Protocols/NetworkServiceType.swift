//
//  NetworkServiceType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

protocol NetworkServiceType {
    func fetch(from category: Category, query: String)
    var terminationHandler: (() -> ())? { get set }
}
