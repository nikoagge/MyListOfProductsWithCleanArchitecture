//
//  ImageCacheManager.swift
//  Networking
//
//  Created by Nikos Aggelidis on 27/10/23.
//

import Alamofire
import AlamofireImage

public protocol ImageCacheManagerDelegate {
    func fetchImage(
        for url: String,
        onCompletion: @escaping (Image) -> Void,
        errorCompletionHandler: @escaping (Error) -> Void
    )
    func cacheImage(
        image: Image,
        for url: String
    )
    func getCachedImage(for url: String) -> Image?
    func clearCachedImage(for url: String)
}

public struct ImageCacheManager: ImageCacheManagerDelegate {
    private var imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    public init() {}
    
    public func fetchImage(
        for url: String,
        onCompletion: @escaping (Image) -> Void,
        errorCompletionHandler: @escaping (Error) -> Void
    ) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                onCompletion(image)
                
            case .failure(let error):
                errorCompletionHandler(error)
            }
        }
    }
    
    public func cacheImage(
        image: Image,
        for url: String
    ) {
        imageCache.add(image, withIdentifier: url)
    }
    
    public func getCachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
    
    public func clearCachedImage(for url: String) {
        imageCache.removeImage(withIdentifier: url)
    }
}
