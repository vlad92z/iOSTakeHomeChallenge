//
//  GetRequestUtility.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import os.log

enum GetRequestUtility {
    
    static let timeoutInterval: Double = 15
    
    static func performPaginatedGetRequest(urlProver: URLProvider, page: Int, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = urlProver.url(for: page)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = GetRequestUtility.timeoutInterval
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
