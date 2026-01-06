//
//  HTTPHeader.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

enum HTTPHeader {
    enum ContentType: String {
        case json = "application/json; charset=utf-8"
    }

    enum ApplicationType: String {
        case sima = "SIMA"
    }

    static var defaultHeaders: [HTTPHeader] {
        [
            .contentType(.json),
        ].filter { !$0.value.originalValue.isEmpty }
    }

    case contentType(_ type: ContentType)
    
    var key: String {
        switch self {
        case .contentType: return "Content-Type"
        }
    }

    var value: HTTPHeaderValue {
        switch self {
        case let .contentType(type):
            return HTTPHeaderValue(originalValue: type.rawValue)
        }
    }
}

struct HTTPHeaderValue {
    let originalValue: String
    let headerValue: String

    init(
        originalValue: String,
        headerValue: String? = nil
    ) {
        self.originalValue = originalValue
        self.headerValue = headerValue ?? originalValue
    }
    
    func getHeaderValue() -> String {
        headerValue
    }
}

extension Array where Element == HTTPHeader {
    func dictionary() -> [String: String] {
        reduce(into: [:]) { result, header in
            result[header.key] = header.value.headerValue
        }
    }
}
