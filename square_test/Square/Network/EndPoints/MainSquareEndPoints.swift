//
//  MainSquareEndPoints.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

enum MainSquareEndPoints {
    case repos
}

extension MainSquareEndPoints: EndPointType {
    
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repos:
            return "/orgs/square/repos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .repos:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .repos:
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: requestHeaders)
        }
    }
    
    var requiresRefresh: Bool {
        false
    }
}
