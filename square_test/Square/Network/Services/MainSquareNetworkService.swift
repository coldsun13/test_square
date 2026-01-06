//
//  MainSquareNetworkService.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

final class MainSquareNetworkService: NetworkService<MainSquareEndPoints>, MainSquareNetworkServiceProtocol {
    func getRepos() async throws(NetworkError) -> [RepositoryModel.Response] {
        try await fetch(endPoint: .repos)
    }
}
