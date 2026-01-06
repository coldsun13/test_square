//
//  NetworkRouter.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

typealias ApiResponse<T> = (Result<T, NetworkError>) -> Void

protocol NetworkRouterProtocol: AnyObject {

    typealias CompletionHandler = (Result<NetworkResponse, NetworkError>) -> Void

    @discardableResult
    func request<EndPoint: EndPointType>(
        _ route: EndPoint,
        completion: @escaping CompletionHandler
    ) -> Cancellable?

    func request<EndPoint: EndPointType>(
        _ route: EndPoint
    ) async throws -> NetworkResponse
}


final class NetworkRouter: NetworkRouterProtocol {

    private let session: URLSession = .shared
    private let responseQueue = DispatchQueue.main
    private let requestBuilder: RequestBuilderProtocol = resolve()

    @discardableResult
    func request<EndPoint: EndPointType>(
        _ route: EndPoint,
        completion: @escaping CompletionHandler
    ) -> Cancellable? {

        do {
            let request = try requestBuilder.buildRequest(from: route)

            let task = session.dataTask(with: request) { data, response, error in
                let networkResponse = NetworkResponse(
                    data: data,
                    urlResponse: response,
                    error: error
                )

                self.responseQueue.async {
                    if let error {
                        completion(.failure(NetworkError(error: error)))
                    } else {
                        completion(.success(networkResponse))
                    }
                }
            }

            task.resume()
            return task

        } catch {
            completion(.failure(NetworkError(type: .badRequest)))
            return nil
        }
    }

    func request<EndPoint: EndPointType>(
        _ route: EndPoint
    ) async throws -> NetworkResponse {
        try await withCheckedThrowingContinuation { continuation in
            self.request(route) { result in
                continuation.resume(with: result)
            }
        }
    }
}
