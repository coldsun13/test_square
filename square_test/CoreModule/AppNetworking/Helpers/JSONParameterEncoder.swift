//
//  JSONParameterEncoder.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

public protocol JSONParameterEncoderProtocol: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Data) throws
}

public final class JSONParameterEncoder: JSONParameterEncoderProtocol {

    public init() {}

    public func encode(urlRequest: inout URLRequest, with parameters: Data) throws {
        urlRequest.httpBody = parameters

        let contentTypeHeader = HTTPHeader.contentType(.json)
        if urlRequest.value(forHTTPHeaderField: contentTypeHeader.key) == nil {
            urlRequest.setValue(contentTypeHeader.value.headerValue,
                                forHTTPHeaderField: contentTypeHeader.key)
        }
    }

    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonAsData

            let contentTypeHeader = HTTPHeader.contentType(.json)
            if urlRequest.value(forHTTPHeaderField: contentTypeHeader.key) == nil {
                urlRequest.setValue(contentTypeHeader.value.headerValue,
                                    forHTTPHeaderField: contentTypeHeader.key)
            }
        } catch {
            throw ParameterEncoderError.encodingFailed
        }
    }

    public func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonAsData

            let contentTypeHeader = HTTPHeader.contentType(.json)
            if urlRequest.value(forHTTPHeaderField: contentTypeHeader.key) == nil {
                urlRequest.setValue(contentTypeHeader.value.headerValue,
                                    forHTTPHeaderField: contentTypeHeader.key)
            }
        } catch {
            throw ParameterEncoderError.encodingFailed
        }
    }
}
