//
//  ProductsListRepositoryImplementation.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Alamofire
import Domain
import RxSwift

final class ProductsListRepositoryImplementation: ProductsListRepository {
    @Injected(\.coreDataLocalStorageManager)
    
    private var cache: CoreDataLocalStorageManagerDelegate
    private let sessionManager: Session = InjectedValues[\.networkManager].session
    
    private func fetchProductsFromAPI(
        onCompletion: @escaping ([Product]) -> Void,
        errorCompletionHandler: @escaping (Error?)-> Void
    ) {
        let _completion: (([Product]) -> Void) = { productsList in
            self.cache.save(productsList: productsList)
            onCompletion(productsList)
        }
            
        let _ = self.sessionManager.request(ProductsListAPI.fetchProductsList)
            .validateResponseWrapper(
                fromType: [Product].self,
                completion: _completion,
                errorCompletion: errorCompletionHandler
            )
    }
    
    func fetchProductsList(
        forceReload: Bool,
        cached: @escaping ([Product]) -> Void,
        onCompletion: @escaping ([Product]) -> Void,
        errorCompletionHandler: @escaping (Error?)-> Void
    ) {
        if forceReload {
            self.fetchProductsFromAPI(
                onCompletion: onCompletion,
                errorCompletionHandler: errorCompletionHandler
            )
            
            return
        }
        
        cache.getProductsList { [weak self] result in
            if case let .success(productsList) = result,
               !productsList.isEmpty {
                cached(productsList)
            } else {
                self?.fetchProductsFromAPI(
                    onCompletion: onCompletion,
                    errorCompletionHandler: errorCompletionHandler
                )
            }
        }
    }
}
