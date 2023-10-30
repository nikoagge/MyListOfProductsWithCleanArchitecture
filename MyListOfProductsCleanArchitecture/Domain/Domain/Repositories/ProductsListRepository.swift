//
//  ProductsListRepository.swift
//  Domain
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import Foundation

public protocol ProductsListRepository {
    func fetchProductsList(
        forceReload: Bool,
        cached: @escaping ([Product])-> Void,
        onCompletion: @escaping ([Product])-> Void,
        errorCompletionHandler: @escaping (Error?)-> Void
     )
}
