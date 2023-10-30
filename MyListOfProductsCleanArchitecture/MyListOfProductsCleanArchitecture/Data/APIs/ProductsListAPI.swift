//
//  ProductsListAPI.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Alamofire

enum ProductsListAPI: URLRequestConvertible {
    var baseURLPath: String {
        return InjectedValues[\.appConfiguration].productsListAPIBaseURL
    }
    
    case fetchProductsList
    
    var path: String {
        switch self {
        case .fetchProductsList:
            return "/v1/api/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchProductsList:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchProductsList:
            return URLEncoding.default
        }
    }
    
    var headers: [String: String] {
        return ["Host": "vivawallet.free.beeceptor.com"]
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = baseURLPath+path
        guard let url = URL(string: urlString) else { throw AFError.invalidURL(url: urlString) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        
        print(request)

        do {
            let encodedRequest = try encoding.encode(request, with: nil)
            
                return encodedRequest
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
    }
}
