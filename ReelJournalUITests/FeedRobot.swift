//
//  FeedRobot.swift
//  ReelJournalUITests
//
//  Created by Dom S on 5/6/26.
//

import XCTest

final class FeedRobot {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func tapNewEntry() -> Self{
        let button = app.buttons[FeedAccessibility.addEntry.description]
        XCTAssert(button.exists, "Expected addEntry button to exist.")
        button.tap()
        return self
    }
    
    @discardableResult
    func validateEntryExists(_ movieName: String, ) -> Self {
        let entry = app.collectionViews.staticTexts[movieName]
        XCTAssert(entry.exists, "Expected entry to exist.")
        return self
    }
}
