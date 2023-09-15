//
//  NetworkError.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import Foundation

enum NetworkError: Error {
    case incorrectURL
    case couldntParseData
    case incorrectData
    case requestWithError
}
