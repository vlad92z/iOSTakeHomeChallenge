//
//  URLProviderTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class URLProviderTests: XCTestCase {

    func testCharacterURL() {
        let url = URLProvider.characters.url(for: 5)
        XCTAssertEqual(url.absoluteString, "https://anapioficeandfire.com/api/characters?page=5")
    }
    
    func testHouseURL() {
        let url = URLProvider.houses.url(for: 5)
        XCTAssertEqual(url.absoluteString, "https://anapioficeandfire.com/api/houses?page=5")
    }
    
    func testBookURL() {
        let url = URLProvider.books.url(for: 5)
        XCTAssertEqual(url.absoluteString, "https://anapioficeandfire.com/api/books?page=5")
    }
}
