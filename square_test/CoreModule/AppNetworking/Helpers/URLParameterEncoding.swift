//
//  URLParameterEncoding.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

protocol URLParameterEncoderProtocol: ParameterEncoder { }

final class URLParameterEncoder: URLParameterEncoderProtocol {
    
    init() {}
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw ParameterEncoderError.missingURL
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(
                    name: key,
                    value: "\(value)"
                )
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        let contentTypeHeader = HTTPHeader.contentType(.urlEncoded)
        if urlRequest.value(forHTTPHeaderField: contentTypeHeader.key) == nil {
            urlRequest.setValue(contentTypeHeader.value.headerValue,
                                forHTTPHeaderField: contentTypeHeader.key)
        }
    }
}
