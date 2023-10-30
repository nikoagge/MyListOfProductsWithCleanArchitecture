//
//  Collection+Extension.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
