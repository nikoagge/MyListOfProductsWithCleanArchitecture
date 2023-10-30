//
//  ServiceError.swift
//  Domain
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import Foundation

enum ServiceError: String {
    case networkError
    case serverError
    case authenticationError
    case invalidRequest
    case notFound
    case decodingError
    
    var message: String {
        switch self {
        case .networkError:
            return "Network error occurred. Please check your internet connection."
            
        case .serverError:
            return "Server error. Please try again later."
            
        case .authenticationError:
            return "Authentication failed. Please log in again."
            
        case .invalidRequest:
            return "Invalid request. Please check your input and try again."
            
        case .notFound:
            return "Resource not found."
            
        case .decodingError:
            return "Error occurred while decoding the response."
        }
    }
}
