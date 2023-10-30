//
//  MyListOfProductsCleanArchitectureTests.swift
//  MyListOfProductsCleanArchitectureTests
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import XCTest
import Domain
import RxBlocking
@testable import MyListOfProductsCleanArchitecture

class ProductsListViewModelTest: XCTestCase {
    static let mockProductsList: [Product] = [
        Product(id: 1, name: "product 1", price: "0.1$", thumbnail: "thumbnail/path/1", image: "image/path/1", description: "product 1 description"),
        Product(id: 2, name: "product 2", price: "0.2$", thumbnail: "thumbnail/path/2", image: "image/path/2", description: "product 2 description"),
        Product(id: 3, name: "product 3", price: "0.3$", thumbnail: "thumbnail/path/3", image: "image/path/3", description: "product 3 description"),
        Product(id: 4, name: "product 4", price: "0.4$", thumbnail: "thumbnail/path/4", image: "image/path/4", description: "product 4 description"),
        Product(id: 5, name: "product 5", price: "0.5$", thumbnail: "thumbnail/path/5", image: "image/path/5", description: "product 5 description")
    ]
    
    struct MockProductsListUseCaseImplementation: ProductsListUseCase {
        var expectation: XCTestExpectation?
        var error: FeedbackInfoMessage?
        var productsList: [Product] = []
        
        func fetchProducts(
            forceReload: Bool,
            cached: @escaping ([Product]) -> Void,
            onCompletion: @escaping ([Product]) -> Void,
            errorCompletionHandler: @escaping (FeedbackInfoMessage) -> Void
        ) {
            if let error = error {
                errorCompletionHandler(error)
            } else if forceReload {
                onCompletion(productsList)
            } else {
                cached(productsList)
            }
            
            expectation?.fulfill()
        }
    }
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testViewModelFetchProductsListEvent() throws {
        let expectation = self.expectation(description: "contains only first page")
        InjectedValues[\.productsListUseCase] = MockProductsListUseCaseImplementation(
            expectation: expectation,
            productsList: ProductsListViewModelTest.mockProductsList
        )
        
        let viewModel = ProductsListViewModel(productActionHandler: InjectedValues[\.productsListCoordinator])
        viewModel.onTriggeredEvent(event: .fetchProductsList)
        
        let state = try viewModel.stateObserver.toBlocking().first()
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertTrue(state?.productsList.count == 5 && state?.productsList[0].id ?? 0 == 1 )
    }
    
    func testViewModelRefreshProductsListEvent() throws {
        let expectation = self.expectation(description: "contains only first page")
        InjectedValues[\.productsListUseCase] = MockProductsListUseCaseImplementation(
            expectation: expectation,
            productsList: ProductsListViewModelTest.mockProductsList)
        
        let viewModel = ProductsListViewModel(productActionHandler: InjectedValues[\.productsListCoordinator])
        viewModel.onTriggeredEvent(event: .refreshProductsList)
        
        let state = try viewModel.stateObserver.toBlocking().first()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(state?.productsList.count == 5 && state?.productsList[0].id ?? 0 == 1 )
    }
}
