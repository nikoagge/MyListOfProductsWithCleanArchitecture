//
//  MainCoordinator.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let productsListCoordinator = InjectedValues[\.productsListCoordinator]
        productsListCoordinator.start()
    }
    
    func goToProductListDetails() { }
}

