//
//  ReelJournalUITests.swift
//  ReelJournalUITests
//
//  Created by Dom S on 4/1/26.
//

import XCTest

final class ReelJournalUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    @MainActor
    func test_new_entry_on_empty_feed() throws {
        let movieName = ""
        // GIVEN the feed is empty
        // WHEN the add button is tapped
        // THEN a new feed entry will appear
        FeedRobot(app: app)
            .tapNewEntry()
            .validateEntryExists(movieName)
            
        // TODO: finish this test
    }
}
