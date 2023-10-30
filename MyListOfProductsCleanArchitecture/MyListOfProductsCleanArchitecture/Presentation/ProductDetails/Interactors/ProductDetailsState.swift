//
//  ProductDetailsState.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import Domain

enum ProductDetailsEvents {
    case pop
}

struct ProductDetailsState {
    let isLoading: Bool
    let selectedProduct: Product
    let feedbackInfoMessage: FeedbackInfoMessage?
    
    init(
        isLoading: Bool = false,
        selectedProduct: Product = Product(),
        feedbackInfoMessage: FeedbackInfoMessage? = nil
    ) {
        self.isLoading = isLoading
        self.selectedProduct = selectedProduct
        self.feedbackInfoMessage = feedbackInfoMessage
    }
    
    func copy(
        isLoading: Bool? = nil,
        selectedProduct: Product? = nil,
        feedbackInfoMessage: FeedbackInfoMessage? = nil
    ) -> ProductDetailsState {
        return ProductDetailsState (
            isLoading: isLoading ?? self.isLoading,
            selectedProduct: selectedProduct ?? self.selectedProduct,
            feedbackInfoMessage: feedbackInfoMessage ?? self.feedbackInfoMessage
        )
    }
}
