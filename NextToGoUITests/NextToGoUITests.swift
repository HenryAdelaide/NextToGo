//
//  NextToGoUITests.swift
//  NextToGoUITests
//
//  Created by Henry Liu on 30/10/2024.
//

import XCTest

final class NextToGoUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var screen: NextToGoScreen {
        NextToGoScreen(app: app)
    }

    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testFilterButtons() {
        XCTAssertTrue(screen.grehoundButton.exists)
        XCTAssertTrue(screen.harnessButton.exists)
        XCTAssertTrue(screen.horseButton.exists)
    }
}
