//
//  URLProvider.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

enum URLProvider {
    case characters
    
    func url(for page: Int) -> URL {
        var url: URL?
        switch self {
        case .characters:
            url = URL(string: "https://anapioficeandfire.com/api/characters?page=\(page)")
        }
        guard let url = url else {
            fatalError("Failed to generate url for \(self) request")
        }
        return url
    }
}
