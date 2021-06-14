//
//  IntExtensionTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class IntExtensionTests: XCTestCase {

    func testNegative() {
        let integer = -500
        XCTAssertEqual(integer.romanNumeral, "")
    }
    
    func testZero() {
        let integer = 0
        XCTAssertEqual(integer.romanNumeral, "")
    }
    
    func testOne() {
        XCTAssertEqual(1.romanNumeral, "I")
    }
    
    func testTwo() {
        XCTAssertEqual(2.romanNumeral, "II")
    }
    
    func testThree() {
        XCTAssertEqual(3.romanNumeral, "III")
    }
    
    func testFour() {
        XCTAssertEqual(4.romanNumeral, "IV")
    }
    
    func testFive() {
        XCTAssertEqual(5.romanNumeral, "V")
    }
    
    func testSix() {
        XCTAssertEqual(6.romanNumeral, "VI")
    }
    
    func testSeven() {
        XCTAssertEqual(7.romanNumeral, "VII")
    }
    
    func testEight() {
        XCTAssertEqual(8.romanNumeral, "VIII")
    }
    
    func testNine() {
        XCTAssertEqual(9.romanNumeral, "IX")
    }
    
    func testTen() {
        XCTAssertEqual(10.romanNumeral, "X")
    }
    
    func testThousand() {
        XCTAssertEqual(1000.romanNumeral, "M")
    }
    
    func testLargeValue() {
        let integer = 3979
        XCTAssertEqual(integer.romanNumeral, "MMMCMLXXIX")
    }
    
    func testRomanNumeralRangeStringEmptyList() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: []), "")
    }
    
    func testRomanNumeralRangeStringSingleValue() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [5]), "V")
    }
    
    func testRomanNumeralRangeStringSingleSequence() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [2, 3, 4, 5]), "II-V")
    }
    
    func testRomanNumeralRangeStringMultipleSequences() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [1, 2, 3, 5, 6]), "I-III, V-VI")
    }
    
    func testRomanNumeralRangeStringFirstAndListWithoutSequence() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [1, 3, 4, 5, 6, 17]), "I, III-VI, XVII")
    }
    
    func testRomanNumeralRangeStringDistinctValues() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [1, 3, 33, 333]), "I, III, XXXIII, CCCXXXIII")
    }
    
    func testRomanNumeralRangeStringOutOfOrder() {
        XCTAssertEqual(Int.romanNumeralRangeString(for: [3, 1, 4, 17, 6, 5]), "I, III-VI, XVII")
    }

}
