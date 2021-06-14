//
//  PaginatedHashableObjectProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

protocol PaginatedHashableObjectProvider {
    
    associatedtype Object: Hashable
    
    func fetchData(for page: Int, completionHandler: @escaping ([Object]?, Error?) -> Void)
}
