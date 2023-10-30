//
//  DomainTests.swift
//  DomainTests
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import XCTest

@testable import Domain
class ProductsListUseCaseTests: XCTestCase {
    var useCase: ProductsListUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        
        let mockRepository = MockProductsListRepository()
        useCase = ProductsListUseCaseImplementation(with: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
        
    func testFetchProductsWithForceReload() {
        let forceReload = true
        
        useCase.fetchProducts(
            forceReload: forceReload,
            cached: { cachedProducts in
                XCTFail("Cached closure should not be called when forceReload is equal to true! 🛑")
            },
            onCompletion: { products in
                XCTAssertFalse(products.isEmpty, "ProductsList should not be empty, weird! 🤔")
            },
            errorCompletionHandler: { error in
                XCTFail("Error completion handler should not be called when forceReload is equal to true. 🫥")
            }
        )
    }
    
    func testFetchProductsCached() {
        let forceReload = false
        useCase.fetchProducts(
            forceReload: forceReload,
            cached: { cachedProducts in
                XCTAssertFalse(cachedProducts.isEmpty, "Cached products should not be empty.")
            },
            onCompletion: { products in
                XCTFail("OnCompletion closure should not be called for cached data.")
            },
            errorCompletionHandler: { error in
                XCTFail("Error completion handler should not be called for cached data.")
            }
        )
    }
        
    func testPerformanceFetchProducts() {
        measure {
            useCase.fetchProducts(
                forceReload: true,
                cached: { _ in },
                onCompletion: { _ in },
                errorCompletionHandler: { _ in }
            )
        }
    }
}
