//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest

final class PokedexUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
