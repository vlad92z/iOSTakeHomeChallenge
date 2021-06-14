//
//  Character.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

struct Character: Codable, Hashable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
    
    /// Returns a formatted string,for which seasons the character appeared in, e.g. "I-V, VII-VIII"
    var seriesString: String {
        var seriesIntegers = [Int]()
        for series in tvSeries {
            guard let seasonNumber = Int(series.replacingOccurrences(of: "Season ", with: "")) else {
                continue
            }
            seriesIntegers.append(seasonNumber)
        }
        return Int.romanNumeralRangeString(for: seriesIntegers)
    }
}
