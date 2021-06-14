//
//  HouseProviderTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class HouseProviderTests: XCTestCase {

    func testFetchData() {
        let houseProvider = HouseProvider()
        let expectTenHouses = expectation(description: "Page 1 contains ten houses")
        houseProvider.fetchData(for: 1) { houses, error in
            XCTAssertEqual(houses?.count, 10)
            XCTAssertNil(error)
            expectTenHouses.fulfill()
        }
        waitForExpectations(timeout: GetRequestUtility.timeoutInterval + 1, handler: nil)
    }
}
