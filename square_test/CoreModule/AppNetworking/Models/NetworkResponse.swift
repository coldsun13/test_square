//
//  NetworkResponse.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

struct NetworkResponse {

    let data: Data?
    let urlResponse: URLResponse?
    let error: Error?

    var status: Int? {
        (urlResponse as? HTTPURLResponse)?.statusCode
    }

    func responseDecodable<T: Decodable>(
        of type: T.Type
    ) -> Result<T, NetworkError> {

        guard let data = data else {
            return .failure(NetworkError(type: .noData))
        }

        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch {
            print("❌ DECODING ERROR:", error)
            print("❌ RAW JSON:")
            print(String(data: data, encoding: .utf8) ?? "NO BODY")

            return .failure(NetworkError(type: .unableToDecodeResponse))
        }
    }
}
