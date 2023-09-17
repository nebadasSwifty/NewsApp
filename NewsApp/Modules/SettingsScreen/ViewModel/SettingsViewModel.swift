//
//  SettingsViewModel.swift
//  NewsApp
//
//  Created by Кирилл on 10.06.2022.
//

import Foundation

class SettingsViewModel: SettingsViewModelType {
    let userKeysSaver: UserKeysProtocol
    var savedNewsArray: [String] {
        get {
            return userKeysSaver.get() as? [String] ?? []
        }
        set {
            userKeysSaver.save(value: newValue)
        }
    }
    
    init(userKeysSaver: UserKeysProtocol) {
        self.userKeysSaver = userKeysSaver
        userKeysSaver.setKey(key: "query")
    }
    
    func numberRows() -> Int {
        return savedNewsArray.count
    }
}
