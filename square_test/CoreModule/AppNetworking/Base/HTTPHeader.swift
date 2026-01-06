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
        case urlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
        case formData = "multipart/form-data"
        case streamText = "text/event-stream"
    }

    enum ApplicationType: String {
        case sima = "SIMA"
    }

    static var defaultHeaders: [HTTPHeader] {
        [
            .contentType(.json),
            .xAppVersion,
            .osType
        ].filter { !$0.value.originalValue.isEmpty }
    }

    case contentType(_ type: ContentType)
    case xAppVersion
    case xApplicationType(_ type: ApplicationType)
    case xConsumer
    case osType
    case deviceId
    case custom(key: String, value: HTTPHeaderValue)
    
    public var key: String {
        switch self {
        case .contentType: return "Content-Type"
        case .xAppVersion: return "X-App-Version"
        case .xApplicationType: return "X-Application-Type"
        case .xConsumer: return "X-Consumer"
        case .osType: return "OsType"
        case .deviceId: return "deviceId"
        case .custom(key: let key, value: _): return key
        }
    }

    var value: HTTPHeaderValue {
        switch self {
        case let .contentType(type):
            return HTTPHeaderValue(originalValue: type.rawValue)
        case .xAppVersion:
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            return HTTPHeaderValue(originalValue: "\(version)")

        case let .xApplicationType(type):
            return HTTPHeaderValue(originalValue: type.rawValue)
            
        case .xConsumer:
            return HTTPHeaderValue(originalValue: "cash")

        case .osType:
            return HTTPHeaderValue(originalValue: "IOS")
            
        case .deviceId:
            return HTTPHeaderValue(originalValue: "-1")
            
        case .custom(key: _, value: let value):
            return value
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
