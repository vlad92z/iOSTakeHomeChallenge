//
//  BookProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import os.log

class BookProvider: PaginatedHashableObjectProvider {
    
    func fetchData(for page: Int, completionHandler: @escaping ([Book]?, Error?) -> Void) {
        GetRequestUtility.performPaginatedGetRequest(urlProver: .books, page: page) { (data, response, error) in
            if let networkError = error {
                os_log(.error, "Book network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "Book network request returned no data")
                completionHandler(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Book.dateFormatter)
                
                let books = try decoder.decode([Book].self, from: data).sorted { $0.released < $1.released }
                completionHandler(books, error)
            } catch {
                os_log(.error, "Book to decode books with error: \(error.localizedDescription)")
                completionHandler(nil, error)
            }
        }
    }
}


