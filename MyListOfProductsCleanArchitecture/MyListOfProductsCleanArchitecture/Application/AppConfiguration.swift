//
//  AppConfiguration.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Foundation

final class AppConfiguration {
    lazy var productsListAPIBaseURL: String = {
        let productsListAPIBaseURL = "https://vivawallet.free.beeceptor.com"
        
        return productsListAPIBaseURL
    }()
}
