//
//  Storyboarded.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import UIKit

protocol Storyboarded {
    static func instantiate()-> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate()-> Self {
        let fullName = NSStringFromClass(self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let className = fullName.components(separatedBy: ".")[safe: 1],
              let vc = storyboard.instantiateViewController(withIdentifier: className) as? Self
        else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard")
        }
        return vc
    }
}

