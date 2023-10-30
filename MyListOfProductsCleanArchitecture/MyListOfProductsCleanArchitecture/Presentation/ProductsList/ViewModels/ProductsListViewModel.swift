//
//  ProductsListViewModel.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Domain
import RxCocoa
import RxSwift

class ProductsListViewModel: ProductActionDispatcher {
    var productActionHandler: ProductActionHandler
    @Injected(\.productsListUseCase)
    private var useCase: ProductsListUseCase
    
    private var state: BehaviorRelay<ProductsListState>
    var stateObserver: Observable<ProductsListState> {
        return state.asObservable()
    }
    
    init(productActionHandler: ProductActionHandler) {
        state = BehaviorRelay(value: ProductsListState())
        self.productActionHandler = productActionHandler
    }
    
    func onTriggeredEvent(event: ProductsListEvents) {
        switch event {
        case .fetchProductsList:
            fetchProductsList()
            
        case .refreshProductsList:
            fetchProductsList(forceReload: true)
            
        case .goToProductDetails(let product):
            productActionHandler.handleAction(action: .GO_TO_PRODUCT_DETAILS(product))
            
        case .presentFeedbackInfoMessage(let feedbackInfoMessage):
            productActionHandler.handleAction(action: .PRESENT_FEEDBACK_INFO_MESSAGE(feedbackInfoMessage: feedbackInfoMessage))
        case .queryProductsList(query: let query):
            break
        }
    }
    
    private func fetchProductsList(forceReload: Bool = false) {
        self.state.accept(state.value.copy(isLoading: true))
        useCase.fetchProducts(forceReload: forceReload)
        { [weak self] productsList in
            guard let self = self else { return }
            let feedbackInfoMessage = FeedbackInfoMessage(
                message: NSLocalizedString(
                "FetchFromLocalStorageFeedback",
                comment: ""
                ),
                feedbackInfoMessageType: .success
            )
            self.state.accept(self.state.value.copy(
                isLoading: false,
                productsList: productsList
            ))
            self.onTriggeredEvent(event: .presentFeedbackInfoMessage(feedbackInfoMessage: feedbackInfoMessage))
            debugPrint(feedbackInfoMessage.message)
        } onCompletion: { [weak self]  productsList in
            guard let self = self else { return }

            let feedbackInfoMessage = FeedbackInfoMessage(
                message: NSLocalizedString(
                    "FetchFromLocalStorageFeedback",
                    comment: ""
                ),
                feedbackInfoMessageType: .success
            )
            self.state.accept(self.state.value.copy(
                isLoading: false,
                productsList: productsList
            ))
            
            self.onTriggeredEvent(event: .presentFeedbackInfoMessage(feedbackInfoMessage: feedbackInfoMessage))
            debugPrint(feedbackInfoMessage.message)
        } errorCompletionHandler: { [weak self] errorMessage in
            guard let self = self else { return }
            self.state.accept(self.state.value.copy(isLoading: false))
            self.onTriggeredEvent(event: .presentFeedbackInfoMessage(feedbackInfoMessage: errorMessage))
            debugPrint(errorMessage.message)
        }
    }
}

