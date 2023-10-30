//
//  ProductsListState.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Foundation
import Domain

struct ProductsListState {
    let isLoading: Bool
    let productsList: [Product]
    
    init(
        isLoading: Bool = false,
        productsList: [Product] = []
    ) {
        self.isLoading = isLoading
        self.productsList = productsList
    }
    
    func copy(
        isLoading: Bool? = nil,
        productsList: [Product]? = nil
    ) -> ProductsListState {
        return ProductsListState (
            isLoading: isLoading ?? self.isLoading,
            productsList: productsList ?? self.productsList
        )
    }
}

enum ProductsListEvents {
    case fetchProductsList
    case refreshProductsList
    case goToProductDetails(product: Product)
    case presentFeedbackInfoMessage(feedbackInfoMessage: FeedbackInfoMessage)
    case queryProductsList(query: String)
}
