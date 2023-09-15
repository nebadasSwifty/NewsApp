//
//  Routable.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import UIKit

protocol Routable: AnyObject {
    func push(_ viewController: UIViewController, animated: Bool)
    func popController(animated: Bool)
    func setRootModule(_ viewController: UIViewController, animated: Bool)
}
