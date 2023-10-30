//
//  CoordinatorsDependencyInjection.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit

private struct MainNavigationControllerProviderKey: InjectionKey {
    static var currentValue: UINavigationController = UINavigationController()
}

private struct MainCoordinatorProviderKey: InjectionKey {
    static var currentValue: MainCoordinator =
    MainCoordinator(navigationController: InjectedValues[\.mainNavigationController])
}

private struct ProductsListCoordinatorProviderKey: InjectionKey {
    @Injected(\.mainNavigationController) var mainNavigationController: UINavigationController
    static var currentValue: ProductsListCoordinator =
    ProductsListCoordinator(navigationController: InjectedValues[\.mainNavigationController])

}

extension InjectedValues {
    var mainNavigationController: UINavigationController {
        get { Self[MainNavigationControllerProviderKey.self]}
        set { Self[MainNavigationControllerProviderKey.self] = newValue }
    }
    
    var mainCoordinator: MainCoordinator {
        get { Self[MainCoordinatorProviderKey.self]}
        set { Self[MainCoordinatorProviderKey.self] = newValue }
    }
    
    var productsListCoordinator: ProductsListCoordinator {
        get { Self[ProductsListCoordinatorProviderKey.self]}
        set { Self[ProductsListCoordinatorProviderKey.self] = newValue }
    }
}
