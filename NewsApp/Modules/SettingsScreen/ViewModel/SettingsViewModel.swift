//
//  SettingsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import Foundation

class SettingsViewModel: SettingsViewModelType {
    var savedNewsArray: [String] = UserDefaults.standard.object(forKey: "query") as? [String] ?? []
    
    func numberRows() -> Int {
        return savedNewsArray.count
    }
    
    func saveArray() {
        UserDefaults.standard.set(savedNewsArray, forKey: "query")
    }
    
}
