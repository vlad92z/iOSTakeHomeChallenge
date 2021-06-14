//
//  URLProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

enum URLProvider {
    case characters
    case houses
    case books
    
    func url(for page: Int) -> URL {
        var url: URL?
        switch self {
        case .characters:
            url = URL(string: "https://anapioficeandfire.com/api/characters?page=\(page)")
        case .houses:
            url = URL(string: "https://anapioficeandfire.com/api/houses?page=\(page)")
        case .books:
            url = URL(string: "https://anapioficeandfire.com/api/books?page=\(page)")
        }
        guard let url = url else {
            fatalError("Failed to generate url for \(self) request")
        }
        return url
    }
}
