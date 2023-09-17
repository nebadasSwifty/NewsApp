//
//  UserKeysSaver.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 16.09.2023.
//

import Foundation

protocol UserKeysProtocol: AnyObject {
    func setKey(key: String)
    func save(value: Any?)
    func get() -> Any?
}

final class UserKeysSaver: UserKeysProtocol {
    private var key: String = ""
    
    func setKey(key: String) {
        self.key = key
    }
    
    func save(value: Any?) {
        guard !key.isEmpty else { return }
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func get() -> Any? {
        guard !key.isEmpty else { return nil }
        return UserDefaults.standard.object(forKey: key)
    }
}
