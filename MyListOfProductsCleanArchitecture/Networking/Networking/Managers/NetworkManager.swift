//
//  NetworkManager.swift
//  Networking
//
//  Created by Nikos Aggelidis on 27/10/23.
//

import Alamofire

public struct NetworkManager {
    public init() {}
    
    lazy public var session: Session = {
        let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 31
        
        return Session(configuration: configuration)
    }()
}
