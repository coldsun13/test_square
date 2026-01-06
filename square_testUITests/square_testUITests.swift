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
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // MARK: - Smoke test

    @MainActor
    func test_app_launches() {
        XCTAssertTrue(app.state == .runningForeground)
    }

    // MARK: - Top bar

    @MainActor
    func test_topbar_is_visible() {
        let topBar = app.otherElements["topbar_container"]
        XCTAssertTrue(topBar.waitForExistence(timeout: 2))
    }

    @MainActor
    func test_topbar_title_is_correct() {
        let title = app.staticTexts["topbar_title"]
        XCTAssertTrue(title.exists)
        XCTAssertEqual(title.label, "Square Repos")
    }

    // MARK: - Content

    @MainActor
    func test_repos_scroll_exists() {
        let scroll = app.scrollViews["repos_scroll"]
        XCTAssertTrue(scroll.waitForExistence(timeout: 3))
    }

    @MainActor
    func test_repos_list_shows_items() {
        let firstCell = app.otherElements["repo_cell_1"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }
}
