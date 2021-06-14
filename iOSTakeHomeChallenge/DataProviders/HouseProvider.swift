//
//  CharacterProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import os.log

class HouseProvider: PaginatedHashableObjectProvider {
    
    func fetchData(for page: Int, completionHandler: @escaping ([House]?, Error?) -> Void) {
        GetRequestUtility.performPaginatedGetRequest(urlProver: .houses, page: page) { (data, response, error) in
            if let networkError = error {
                os_log(.error, "House network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "House network request returned no data")
                completionHandler(nil, error)
                return
            }
            
            do {
                let houses = try JSONDecoder().decode([House].self, from: data)
                completionHandler(houses, error)
            } catch {
                os_log(.error, "Failed to decode houses with error: \(error.localizedDescription)")
                completionHandler(nil, error)
            }
        }
    }
}


