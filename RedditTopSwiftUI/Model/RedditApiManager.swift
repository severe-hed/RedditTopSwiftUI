//
//  RedditApiManager.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Foundation

enum RedditEndpoint: String {
    case top = "top.json"
}

final class RedditApiManager {
    static let shared = RedditApiManager()
    private let apiURL = "https://www.reddit.com/"
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetchTop(limit: Int = 25, after: String? = nil, reloadCache: Bool = false, completion: @escaping (Result<[RedditPost], NSError>) -> Void) {
        var urlString = apiURL + RedditEndpoint.top.rawValue
        urlString += "?limit=" + String(limit)
        
        if let after = after {
            urlString += "&after=" + after
        }
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bad url"])))
            return
        }
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if !reloadCache, let response = cache.cachedResponse(for: request) {
            let data = response.data
            DispatchQueue.global().async {
                self.processResponseData(data: data, completion)
            }
        }
        else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error as NSError))
                }
                else if let data = data, let response = response {
                    self.processResponseData(data: data, completion)
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedResponse, for: request)
                }
                else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])))
                }
                }.resume()
        }
    }
    
    private func processResponseData(data: Data, _ completion: @escaping (Result<[RedditPost], NSError>) -> Void) {
        do {
            let posts = try JSONDecoder().decode(RedditListing.self, from: data).posts
            completion(.success(posts))
        }
        catch let error as NSError {
            completion(.failure(error))
        }
    }
}
