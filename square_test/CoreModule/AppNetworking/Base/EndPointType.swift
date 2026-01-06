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

    var includeDefaultHeaders: Bool { get }
    var headers: [HTTPHeader]? { get }
    var requestHeaders: [HTTPHeader] { get }
    
    var requestTimeout: Double { get }
    
    var requiresRefresh: Bool { get }
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

