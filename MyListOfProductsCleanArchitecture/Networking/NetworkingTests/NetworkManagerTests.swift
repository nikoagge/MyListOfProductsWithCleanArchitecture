//
//  NetworkManagerTests.swift
//  NetworkingTests
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import XCTest
import Alamofire

@testable import Networking

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testSessionTimeoutInterval() {
        XCTAssertEqual(networkManager.session.session.configuration.timeoutIntervalForRequest, 31)
    }
    
    func testSessionIsLazyLoaded() {
        XCTAssertNil(networkManager.session.session)
        _ = networkManager.session
        XCTAssertNotNil(networkManager.session.session)
    }
    
    func testPerformanceInitialization() {
        measure {
            _ = NetworkManager()
        }
    }
}
