//
//  ProductEntity+Mapper.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import CoreData
import Domain

extension Product {
    func toEntity(in context: NSManagedObjectContext) -> ProductEntity {
        let productEntity: ProductEntity = .init(context: context)
        productEntity.id = Int32(id ?? 0)
        productEntity.name = name
        productEntity.price = price
        productEntity.image = image
        productEntity.thumbnail = thumbnail
        productEntity.product_description = description
        
        return productEntity
    }
}

extension ProductEntity {
    func toDto() -> Product{
        return .init(
            id: Int(id),
            name: name,
            price: price,
            thumbnail: thumbnail,
            image: image,
            description: product_description
        )
    }
}
