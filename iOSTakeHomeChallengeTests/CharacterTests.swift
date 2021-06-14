//
//  CharacterTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Vlad on 14/06/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class CharacterTests: XCTestCase {

    func testSeriesStringNoSeasons() {
        let character = createCharacter(with: [])
        XCTAssertEqual(character.seriesString, "")
    }
    
    func testSeriesStringSomeInvalidInput() {
        let character = createCharacter(with: ["Season", "", "Season 2", "Season 3"])
        XCTAssertEqual(character.seriesString, "II-III")
    }
    
    // MARK: Utility
    func createCharacter(with seasons: [String]) -> Character {
        return Character(url: "",
                         name: "",
                         gender: "",
                         culture: "",
                         born: "",
                         died: "",
                         aliases: [],
                         father: "",
                         mother: "",
                         spouse: "",
                         allegiances: [],
                         books: [],
                         povBooks: [],
                         tvSeries: seasons,
                         playedBy: [""])
    }
}
