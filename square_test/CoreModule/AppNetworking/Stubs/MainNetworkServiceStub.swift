//
//  MainNetworkServiceStub.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

final class MainSquareNetworkServiceStub: MainSquareNetworkServiceProtocol {
    func getRepos() async throws(square_test.NetworkError) -> [square_test.RepositoryModel.Response] {
        [
            .init(id: 1, name: "Repo One", description: "Desc"),
            .init(id: 2, name: "Repo Two", description: nil)
        ]
    }
}
