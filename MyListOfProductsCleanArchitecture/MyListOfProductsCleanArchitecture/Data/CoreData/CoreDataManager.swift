//
//  CoreDataManager.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Foundation
import CoreData

enum CoreDataLocalStorageManagerError: Error {
    case deleteError(Error)
    case readError(Error)
    case saveError(Error)
}

class CoreDataManager: NSObject {
    fileprivate override init() {}
    
    override class func copy() -> Any {
        fatalError("You are not allowed to use copy method on singleton!💀")
    }
    
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyListOfProductsCleanArchitecture")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage some unresolved error \(error), \(error.userInfo), needs more inspection 🕵️‍♂️")
            }
        }
        
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint(nserror)
                //Should not be used on a production app, actually it should not reach this point at all.
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func performBackgroundTask(_ withCompletionHandler: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(withCompletionHandler)
    }
}
