//
//  Dynamic.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import Foundation

class Dynamic<T> {

    typealias Listener = (T) -> ()
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }

    init(_ value: T) {
        self.value = value
    }
}
