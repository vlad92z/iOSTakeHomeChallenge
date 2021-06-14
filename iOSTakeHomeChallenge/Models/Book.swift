//
//  Book.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

struct Book: Codable, Hashable {
    
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2014-06-17T00:00:00
    
    let url: String
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: Date
    let characters: [String]
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}
