//
//  ProductsListUseCase.swift
//  Domain
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import Foundation

public protocol ProductsListUseCase {
    func fetchProducts(
        forceReload: Bool,
        cached: @escaping ([Product]) -> Void,
        onCompletion: @escaping ([Product]) -> Void,
        errorCompletionHandler: @escaping (FeedbackInfoMessage)-> Void
    )
}

public final class ProductsListUseCaseImplementation: ProductsListUseCase {
    private var productsListRepository: ProductsListRepository
    
    public init(with productsListRepository: ProductsListRepository) {
        self.productsListRepository = productsListRepository
    }
    
    public func fetchProducts(
        forceReload: Bool,
        cached: @escaping ([Product]) -> Void,
        onCompletion: @escaping ([Product]) -> Void,
        errorCompletionHandler: @escaping (FeedbackInfoMessage) -> Void
    ) {
        productsListRepository.fetchProductsList(
            forceReload: forceReload,
            cached: cached,
            onCompletion: onCompletion,
            errorCompletionHandler: { error in
                let feedbackInfoMessage = FeedbackInfoMessage(
                    message: error?.localizedDescription ?? "Something Went Wrong",
                    feedbackInfoMessageType: .error
                )
                errorCompletionHandler(feedbackInfoMessage)
            }
        )
    }
}
