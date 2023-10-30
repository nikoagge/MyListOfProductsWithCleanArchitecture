//
//  NSPersistentContainer+Extension.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import CoreData

extension NSPersistentContainer {
    //TODO: Check how to use this implementation later
    func performBackgroundTask<T>(
        _ block: @escaping (NSManagedObjectContext) async throws -> T) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.performBackgroundTask { backgroundContext in
                Task {
                    do {
                        let result = try await block(backgroundContext)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
