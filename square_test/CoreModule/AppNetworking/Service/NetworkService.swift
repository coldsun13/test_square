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

    func fetch<T: Decodable>(endPoint: EndPoint) async throws(NetworkError) -> T {
        do {
            let response = try await router.request(endPoint)

            if let status = response.status, !(200...299).contains(status) {
                throw NetworkError(type: .failed)
            }

            switch response.responseDecodable(of: T.self) {
            case .success(let model):
                return model
            case .failure(let error):
                throw error
            }

        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError(error: error)
        }
    }
}
