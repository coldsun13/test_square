//
//  NetworkService.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

class NetworkService<EndPoint: EndPointType>: @unchecked Sendable {

    typealias CompletionHandler<T> = (Result<T, NetworkError>) -> Void

    private let router: NetworkRouterProtocol

    init() {
        self.router = resolve()
    }

    // MARK: - Data

    @discardableResult
    func fetch(
        endPoint: EndPoint,
        completion: @escaping CompletionHandler<Data>
    ) -> Cancellable? {

        router.request(endPoint) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    completion(.failure(NetworkError(type: .noData)))
                    return
                }
                completion(.success(data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetch(endPoint: EndPoint) async throws -> Data {
        let response = try await router.request(endPoint)

        guard let data = response.data else {
            throw NetworkError(type: .noData)
        }

        return data
    }

    // MARK: - Decodable

    @discardableResult
    func fetchDecodable<T: Decodable>(
        endPoint: EndPoint,
        completion: @escaping CompletionHandler<T>
    ) -> Cancellable? {

        router.request(endPoint) { result in
            switch result {
            case .success(let response):
                let result: Result<T, NetworkError> =
                    response.responseDecodable(of: T.self)
                completion(result)

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchDecodable<T: Decodable>(
        endPoint: EndPoint
    ) async throws -> T {

        let response = try await router.request(endPoint)

        switch response.responseDecodable(of: T.self) {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
}
