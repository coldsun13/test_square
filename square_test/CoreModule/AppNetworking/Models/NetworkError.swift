//
//  NetworkError.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

struct NetworkError: Error, Equatable {

    let type: ResponseType

    init(type: ResponseType) {
        self.type = type
    }

    init(error: Error) {
        self.type = .failed
    }

    enum ResponseType: Equatable {
        case badRequest
        case noData
        case failed
        case unableToDecodeResponse
    }
}
