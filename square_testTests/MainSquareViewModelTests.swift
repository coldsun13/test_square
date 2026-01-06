//
//  MainSquareViewModelTests.swift
//  square_testTests
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import XCTest

@testable import square_test

final class MainSquareViewModelTests: XCTestCase {

    func test_fetchData_success_setsItems() async {
        // GIVEN
        let networkMock = MainSquareNetworkServiceMock()
        networkMock.result = .success([
            .init(id: 1, name: "Repo One", description: "Desc 1"),
            .init(id: 2, name: "Repo Two", description: nil)
        ])

        let viewModel = MainSquareViewModel(
            state: .init(),
            router: MainSquareRouterMock(),
            inputData: MainSquareInputData(),
            dependencies: .init(networkService: networkMock)
        )

        let expectation = XCTestExpectation(description: "Items loaded")

        // WHEN
        viewModel.handle(action: .fetchData)

        // THEN (polling state)
        Task {
            while viewModel.state.items.isEmpty {
                try await Task.sleep(nanoseconds: 10_000_000) // 10ms
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1.0)

        let items = viewModel.state.items
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items[0].title, "Repo One")
        XCTAssertEqual(items[1].subtitle, "No description")
    }
}
