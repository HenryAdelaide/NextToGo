//
//  NextToGoScreen.swift
//  NextToGoUITests
//
//  Created by Henry Liu on 3/11/2024.
//

import Foundation
import XCTest

class NextToGoScreen {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    //MARK: - Greyhound Filter Button
    var grehoundButton: XCUIElement {
        app.buttons[AccesibilityManager.GreyhoundCategory.accessibilityIdentifier]
    }
    
    //MARK: - Harness Filter Button
    var harnessButton: XCUIElement {
        app.buttons[AccesibilityManager.HarnessCategory.accessibilityIdentifier]
    }
    
    //MARK: - Horse Filter Button
    var horseButton: XCUIElement {
        app.buttons[AccesibilityManager.HorseCategory.accessibilityIdentifier]
    }
}
