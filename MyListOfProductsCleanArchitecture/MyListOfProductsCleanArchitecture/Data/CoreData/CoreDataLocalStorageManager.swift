//
//  CoreDataLocalStorageManager.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import CoreData
import Domain

protocol CoreDataLocalStorageManagerDelegate {
    func getProductsList(onCompletion: @escaping (Result<[Product], CoreDataLocalStorageManagerError>) -> Void)
    func save(productsList: [Product])
}

class CoreDataLocalStorageManagerImplementation: CoreDataLocalStorageManagerDelegate {
    private let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    private func fetchRequest() -> NSFetchRequest<ProductEntity> {
        let request: NSFetchRequest = ProductEntity.fetchRequest()
        
        return request
    }
    
    private func deleteResponseFromCoreData(in context: NSManagedObjectContext) {
        let productRequest = ProductEntity.fetchRequest()
        
        do {
            try context.fetch(productRequest).forEach { product in
                context.delete(product)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    private func getProductsList(
        for fetchRequest: NSFetchRequest<ProductEntity>,
        onCompletion: @escaping (Result<[Product], CoreDataLocalStorageManagerError>) -> Void
    ) {
        coreDataManager.performBackgroundTask { context in
            
            do {
                var productsList: [Product] = []
                try context.fetch(fetchRequest).forEach{
                    productsList.append($0.toDto())
                }
                
                debugPrint("Fetch \(productsList.count) products from local storage! 🚀")
                onCompletion(.success(productsList))
            } catch {
                debugPrint("Fail to retrieve products from local storage...😔")
                onCompletion(.failure(CoreDataLocalStorageManagerError.readError(error)))
            }
        }
    }
    
    func getProductsList(onCompletion completionHandler: @escaping (Result<[Product], CoreDataLocalStorageManagerError>) -> Void) {
        getProductsList(
            for: fetchRequest(),
            onCompletion: completionHandler
        )
    }
    
    func save(productsList: [Product]) {
        coreDataManager.performBackgroundTask { context in
            do {
                self.deleteResponseFromCoreData(in: context)
                productsList.forEach {
                    context.insert($0.toEntity(in: context))
                }
                try context.save()
            } catch {
                debugPrint("Some unresolved error with core data \(error), \((error as NSError).userInfo), shit! 😡")
            }
        }
    }
}



