//
//  CharacterProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import os.log

class CharacterProvider: PaginatedHashableObjectProvider {
    
    func fetchData(for page: Int, completionHandler: @escaping ([Character]?, Error?) -> Void) {
        GetRequestUtility.performPaginatedGetRequest(urlProver: .characters, page: page) { (data, response, error) in
            if let networkError = error {
                os_log(.error, "Character network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "Character network request returned no data")
                completionHandler(nil, error)
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                completionHandler(characters, error)
            } catch {
                os_log(.error, "Failed to decode characters with error: \(error.localizedDescription)")
                completionHandler(nil, error)
            }
        }
    }
}


