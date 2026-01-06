//
//  square_testApp.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import SwiftUI

@main
struct square_testApp: App {

    init() {
        if ProcessInfo.processInfo.arguments.contains("UI_TESTING") {
            DependencyContainer.setupForUITests()
        } else {
            DependencyContainer.setup()
        }
    }

    var body: some Scene {
        WindowGroup {
            MainSquareContainerView()
        }
    }
}
