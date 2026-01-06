//
//  square_testUITests.swift
//  square_testUITests
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import XCTest

final class square_testUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("UI_TESTING")
        app.launch()
    }
    
    func test_app_launches() {
        XCTAssertEqual(app.state, .runningForeground)
    }
    
    func test_topbar_is_visible() {
        XCTAssertTrue(
            app.otherElements["topbar_container"]
                .waitForExistence(timeout: 5)
        )
    }
    
    func test_topbar_title_is_correct() {
        let title = app.staticTexts["topbar_title"]
        XCTAssertTrue(title.waitForExistence(timeout: 5))
        XCTAssertEqual(title.label, "Square Repos")
    }
    
    func test_repos_list_shows_items() {
        let title = app.staticTexts["repo_title_1"]
        XCTAssertTrue(title.waitForExistence(timeout: 5))
    }
    
    func test_repos_scroll_exists() {
        XCTAssertTrue(
            app.scrollViews["repos_scroll"]
                .waitForExistence(timeout: 3)
        )
    }
}
