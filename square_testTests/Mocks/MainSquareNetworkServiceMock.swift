//
//  MainSquareNetworkServiceMock.swift
//  square_testTests
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

@testable import square_test

final class MainSquareNetworkServiceMock: MainSquareNetworkServiceProtocol {
    func getRepos() async throws(square_test.NetworkError) -> [square_test.RepositoryModel.Response] {
        switch result {
        case .success(let repos):
            return repos
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }
    
    var result: Result<[RepositoryModel.Response], NetworkError>!
}
