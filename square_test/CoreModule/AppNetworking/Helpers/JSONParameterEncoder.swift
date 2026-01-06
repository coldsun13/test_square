//
//  JSONParameterEncoder.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

protocol JSONParameterEncoderProtocol: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Data) throws
}

final class JSONParameterEncoder: JSONParameterEncoderProtocol {

    init() {}

    func encode(urlRequest: inout URLRequest, with parameters: Data) throws {
        urlRequest.httpBody = parameters

        let contentTypeHeader = HTTPHeader.contentType(.json)
        if urlRequest.value(forHTTPHeaderField: contentTypeHeader.key) == nil {
            urlRequest.setValue(contentTypeHeader.value.headerValue,
                                forHTTPHeaderField: contentTypeHeader.key)
        }
    }

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
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

    func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {
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
