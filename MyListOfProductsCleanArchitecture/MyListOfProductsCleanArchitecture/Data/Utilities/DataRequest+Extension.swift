//
//  DataRequest+Extension.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Alamofire

extension DataRequest {
    
    @discardableResult
    func prettyPrintedJsonResponse() -> Self {
        return responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let data = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted),
                   let text = String(data: data, encoding: .utf8) {
                    print("📗 prettyPrinted JSON response: \n \(text)")
                }
            case .failure: break
            }
        }
    }
    
    func validateResponseWrapper<T>(
        fromType: T.Type,
        completion: @escaping (T) -> Void,
        errorCompletion: @escaping (Error?)-> Void
    ) -> Self where T: Codable {
        return validate()
            .prettyPrintedJsonResponse()
            .responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result{
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    errorCompletion(error.underlyingError)
                }
            }
    }
}
