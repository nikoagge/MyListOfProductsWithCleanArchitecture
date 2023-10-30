//
//  MockProductsListRepository.swift
//  DomainTests
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import Domain

class MockProductsListRepository: ProductsListRepository {
    private var cachedProducts: [Product] = []
        
    private func fetchProductsListFromAPI(completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let sampleProducts: [Product] = [
            Product(
                id: 1,
                name: "Product 1"
            ),
            Product(
                id: 2,
                name: "Product 2"
            ),
            Product(
                id: 3,
                name: "Product 3"
            ),
            Product(
                id: 4,
                name: "Product 4"
            )
        ]
            
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            completionHandler(sampleProducts, nil)
        }
    }
    func fetchProductsList(
        forceReload: Bool,
        cached: @escaping ([Product]) -> Void,
        onCompletion: @escaping ([Product]) -> Void,
        errorCompletionHandler: @escaping (Error?) -> Void
    ) {
        if forceReload || cachedProducts.isEmpty {
            fetchProductsListFromAPI { [weak self] products, error in
                if let error = error {
                    errorCompletionHandler(error)
                } else if let products = products {
                    self?.cachedProducts = products
                    onCompletion(products)
                }
            }
        } else {
            cached(cachedProducts)
        }
    }
}
