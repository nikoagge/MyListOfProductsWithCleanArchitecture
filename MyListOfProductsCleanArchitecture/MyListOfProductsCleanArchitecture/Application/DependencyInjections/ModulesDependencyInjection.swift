//
//  ModulesDependencyInjection.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Domain
import Networking

private struct AppConfigurationKey: InjectionKey {
    static var currentValue: AppConfiguration = AppConfiguration()
}

private struct NetworkManagerKey: InjectionKey {
    static var currentValue:NetworkManager =  NetworkManager()
}

private struct ImageCacheManagerKey: InjectionKey {
    static var currentValue: ImageCacheManager = ImageCacheManager()
}

private struct ProductsListRepositoryKey: InjectionKey {
    static var currentValue: ProductsListRepository = ProductsListRepositoryImplementation()
}

private struct CoreDataLocalStorageManagerProviderKey: InjectionKey {
    static var currentValue: CoreDataLocalStorageManagerDelegate = CoreDataLocalStorageManagerImplementation()
}

private struct ProductsListUseCaseKey: InjectionKey {
    static var currentValue: ProductsListUseCase = ProductsListUseCaseImplementation(with: InjectedValues[\.productsListRepository])
}

extension InjectedValues {
    var appConfiguration: AppConfiguration {
        get { Self[AppConfigurationKey.self] }
        set { Self[AppConfigurationKey.self] = newValue }
    }
    
    var networkManager: NetworkManager {
        get { Self[NetworkManagerKey.self] }
        set { Self[NetworkManagerKey.self] = newValue }
    }
    
    var imageCacheManager: ImageCacheManager {
        get { Self[ImageCacheManagerKey.self] }
        set { Self[ImageCacheManagerKey.self] = newValue }
    }
    
    var productsListRepository: ProductsListRepository {
        get { Self[ProductsListRepositoryKey.self] }
        set { Self[ProductsListRepositoryKey.self] = newValue }
    }
    
    var coreDataLocalStorageManager: CoreDataLocalStorageManagerDelegate {
        get { Self[CoreDataLocalStorageManagerProviderKey.self] }
        set { Self[CoreDataLocalStorageManagerProviderKey.self] = newValue }
    }
    
    var productsListUseCase: ProductsListUseCase {
        get { Self[ProductsListUseCaseKey.self] }
        set { Self[ProductsListUseCaseKey.self] = newValue }
    }
}

