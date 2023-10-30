//
//  ProductDetailsViewModel.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import RxCocoa
import Domain
import RxSwift

class ProductDetailsViewModel: ProductActionDispatcher {
    private var state: BehaviorRelay<ProductDetailsState>

    var productActionHandler: ProductActionHandler
    var stateObserver: Observable<ProductDetailsState> {
        return state.asObservable()
    }
    
    init(
        product: Product,
        productActionHandler: ProductActionHandler
    ) {
        state = BehaviorRelay(value: ProductDetailsState(selectedProduct: product))
        self.productActionHandler = productActionHandler
    }
    
    func onTriggeredEvent(event: ProductDetailsEvents) {
        switch event {
        case .pop:
            productActionHandler.handleAction(action: .POP)
        }
    }
}
