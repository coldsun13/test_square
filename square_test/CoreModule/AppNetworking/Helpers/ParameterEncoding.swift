//
//  ParameterEncoding.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws
}

extension ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {}
}

enum ParameterEncoderError : String, Error {
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

enum ParameterEncoding {
    
    case jsonEncoding
    
    func encode(urlRequest: inout URLRequest, body: Parameters?, url: Parameters?) throws {
        do {
            switch self {
            case .jsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
    
    func encode(urlRequest: inout URLRequest, body: [Parameters]?, url: Parameters?) throws {
        do {
            switch self {
            case .jsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}
