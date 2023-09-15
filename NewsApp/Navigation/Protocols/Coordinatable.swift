//
//  Coordinatable.swift
//  NewsApp
//
//  Created by Кирилл on 09.06.2022.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    var router: Routable { get }
    
    func start()
}
