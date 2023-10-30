//
//  ImageCacheManagerTests.swift
//  NetworkingTests
//
//  Created by Nikos Aggelidis on 28/10/23.
//

import XCTest
@testable import Networking

final class ImageCacheManagerTests: XCTestCase {
    var imageCacheManager: ImageCacheManager!
    
    override func setUp() {
        super.setUp()
        imageCacheManager = ImageCacheManager()
    }
    
    override func tearDown() {
        imageCacheManager = nil
        super.tearDown()
    }

    func testFetchImage() {
        let imageURL = "http://fakeimg.pl/400x400/?text=massa.%20Integer"
        let expectation = XCTestExpectation(description: "Image fetched successfully!")

        Task {
            if let image = try? await imageCacheManager.fetchImage(for: imageURL) {
                XCTAssertNotNil(image)
                expectation.fulfill()
            } else {
                XCTFail("Image fetch failed.")
            }
        }

        wait(for: [expectation], timeout: 13)
    }
    
    func testCacheImage() {
        let imageURL = "http://fakeimg.pl/400x400/?text=massa.%20Integer"
        let image = UIImage(named: "testImage") ?? UIImage()
        XCTAssertNotNil(image)

        imageCacheManager.cacheImage(image: image, for: imageURL)
        
        if let cachedImage = imageCacheManager.getCachedImage(for: imageURL) {
            XCTAssertNotNil(cachedImage)
        } else {
            XCTFail("Image cache failed")
        }
    }
    
    func testClearCachedImage() {
        let imageURL = "http://fakeimg.pl/400x400/?text=massa.%20Integer"
        let image = UIImage(named: "testImage") ?? UIImage()
        XCTAssertNotNil(image)
        
        imageCacheManager.cacheImage(image: image, for: imageURL)
        
        if let cachedImage = imageCacheManager.getCachedImage(for: imageURL) {
            XCTAssertNotNil(cachedImage)
            imageCacheManager.clearCachedImage(for: imageURL)
            let clearedImage = imageCacheManager.getCachedImage(for: imageURL)
            XCTAssertNil(clearedImage)
        } else {
            XCTFail("Image cache or clear failed")
        }
    }

    func testPerformanceFetchImage() {
        measure {
            let imageURL = "http://fakeimg.pl/400x400/?text=massa.%20Integer"
            let expectation = XCTestExpectation(description: "Image fetched successfully!")
            
            Task {
                if let image = try? await imageCacheManager.fetchImage(for: imageURL) {
                    XCTAssertNotNil(image)
                    expectation.fulfill()
                } else {
                    XCTFail("Image fetch failed")
                }
            }

            wait(for: [expectation], timeout: 13)
        }
    }
}
