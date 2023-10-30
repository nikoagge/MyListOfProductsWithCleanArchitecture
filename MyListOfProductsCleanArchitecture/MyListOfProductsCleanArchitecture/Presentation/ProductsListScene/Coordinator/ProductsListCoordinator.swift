//
//  ProductsListCoordinator.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit
import Domain

enum ProductsListNavigationActions {
    case POP
    case GO_TO_PRODUCT_DETAILS(_ product: Product)
    case PRESENT_FEEDBACK_INFO_MESSAGE(feedbackInfoMessage: FeedbackInfoMessage)
}

protocol ProductActionHandler: AnyObject {
    func handleAction(action: ProductsListNavigationActions)
}

protocol ProductActionDispatcher: AnyObject {
    var productActionHandler: ProductActionHandler { get set }
}

class ProductsListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let productsListViewModel = ProductsListViewModel(productActionHandler: self)
        let productsListViewController = ProductsListViewController(viewModel: productsListViewModel)
        navigationController.pushViewController(productsListViewController, animated: false)
    }
}

extension ProductsListCoordinator: ProductActionHandler {
    func handleAction(action: ProductsListNavigationActions) {
        switch action {
        case .POP:
            break
        case .PRESENT_FEEDBACK_INFO_MESSAGE(let feedbackInfoMessage):
            DispatchQueue.main.async {
                (UIApplication.shared.keyWindow as? BaseWindow)?
                    .presentingFeedbackInfoMessage(feedbackInfoMessage: feedbackInfoMessage)
            }
            
        case .GO_TO_PRODUCT_DETAILS(let product):
            let viewModel = ProductDetailsViewModel(
                product: product,
                productActionHandler: self
            )
            let productDetailsViewController = ProductDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(productDetailsViewController, animated: true)
        }
    }
}
