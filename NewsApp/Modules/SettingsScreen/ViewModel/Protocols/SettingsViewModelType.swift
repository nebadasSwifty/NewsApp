//
//  SettingsViewModelType.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import Foundation

protocol SettingsViewModelType {
    func numberRows() -> Int
    var savedNewsArray: [String] { get set }
}
