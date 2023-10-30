//
//  ServiceErrorModel.swift
//  Domain
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import Foundation

public struct ServiceErrorModel:
    Equatable,
    Error
{
    let code: Int
    let description: String
    let message: String
}
