//
//  Int+Extension.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation

// Mark:
extension Int {
    
    /// Returns a roman numeral string. Will return an empty string for values less than 1 or higher than 3999.
    var romanNumeral: String {
        guard self > 0 && self < 3999 else {
            return ""
        }
        
        let arabicRomanPairs: [(int: Int, roman: String)] = [
            (1000, "M"),
            (900, "CM"),
            (500, "D"),
            (400, "CD"),
            (100, "C"),
            (90, "XC"),
            (50, "L"),
            (40, "XL"),
            (10, "X"),
            (9, "IX"),
            (5, "V"),
            (4, "IV"),
            (1, "I")
        ]
        
        var result = ""
        var remainder = self
        
        for valuePair in arabicRomanPairs {
            guard remainder >= valuePair.int else {
                continue
            }
            
            let count = remainder/valuePair.int
            remainder = remainder - valuePair.int * count
            result.append(String(repeating: valuePair.roman, count: count))
        }
        
        return result
    }
    
    /// Given a list of integers, returns a roman numeral string representation, where subsequent integers are represented as a range.
    /// - Parameter seriesList: list of integers
    /// - Returns: roman numberal string representation, e.g. "I-V, VII-VIII"
    static func romanNumeralRangeString(for integers: [Int]) -> String {
        var result = ""
        let sortedIntegers = integers.sorted()
        guard sortedIntegers.count > 0 else {
            return result
        }
        
        if sortedIntegers.count == 1 {
            return sortedIntegers[0].romanNumeral
        } else {
            result += "\(sortedIntegers[0].romanNumeral)"
            
            var isSpanning = false
            let finalIndex = sortedIntegers.count - 1
            for i in 1...finalIndex {
                let previousValue = sortedIntegers[i - 1]
                if sortedIntegers[i] - previousValue == 1 {
                    if i == finalIndex {
                        result += "-\(sortedIntegers[i].romanNumeral)"
                        break
                    }
                    isSpanning = true
                } else if isSpanning {
                    result += "-\(previousValue.romanNumeral), \(sortedIntegers[i].romanNumeral)"
                    isSpanning = false
                } else {
                    result += ", \(sortedIntegers[i].romanNumeral)"
                }
            }
        }
        return result
    }
}
