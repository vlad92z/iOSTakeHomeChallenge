//
//  URLProviderTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class URLProviderTests: XCTestCase {

    func testURL() {
        let url = URLProvider.characters.url(for: 5)
        XCTAssertEqual(url.absoluteString, "https://anapioficeandfire.com/api/characters?page=5")
    }
}
