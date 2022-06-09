//
//  NetworkServiceType.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import Foundation

protocol NetworkServiceType {
    func fetch(from category: Category, page: Int, completion: @escaping ([Article]) -> Void)
}
