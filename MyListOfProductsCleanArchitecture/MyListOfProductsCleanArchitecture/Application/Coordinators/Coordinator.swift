//
//  Coordinator.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
