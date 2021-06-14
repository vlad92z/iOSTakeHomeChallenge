//
//  BookProviderTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class BookProviderTests: XCTestCase {

    func testFetchData() {
        let houseProvider = BookProvider()
        let expectTwoBooks = expectation(description: "Page 2 contains 2 books")
        houseProvider.fetchData(for: 2) { books, error in
            XCTAssertEqual(books?.count, 2)
            XCTAssertNil(error)
            expectTwoBooks.fulfill()
        }
        waitForExpectations(timeout: GetRequestUtility.timeoutInterval + 1, handler: nil)
    }
}
