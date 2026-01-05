//
//  EndPointType.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    /// Added because at **line 22** in `RequestBuilder.swift` for some reasons some arbitrarily selected "default" headers are always included in the request. No opt-out provided. So the "headers" are actually additional headers on top of "default" headers. Pure genius.
    var includeDefaultHeaders: Bool { get }
    var headers: [HTTPHeader]? { get }
    var requestHeaders: [HTTPHeader] { get }
    
    var requestTimeout: Double { get }
    
    var mockEnabled: Bool { get }
    var mockDataFileName: String? { get }
    
    var requiresRefresh: Bool { get }
    
    var bundle: Bundle { get }
}

extension EndPointType {

    var requestTimeout: Double {
        30.0
    }

    var includeDefaultHeaders: Bool {
        true
    }

    var requiresRefresh: Bool {
        true
    }
    
    var headers: [HTTPHeader]? {
        nil
    }
    
    var requestHeaders: [HTTPHeader] {
        headers.or([])
    }
}
