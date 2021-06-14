//
//  CharacterProviderTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class CharacterProviderTests: XCTestCase {

    func testFetchData() {
        let characterProvider = CharacterProvider()
        let expectTenCharacters = expectation(description: "Page 1 contains ten characters")
        characterProvider.fetchData(for: 1) { characters, error in
            XCTAssertEqual(characters?.count, 10)
            XCTAssertNil(error)
            expectTenCharacters.fulfill()
        }
        waitForExpectations(timeout: GetRequestUtility.timeoutInterval + 1, handler: nil)
    }
}
