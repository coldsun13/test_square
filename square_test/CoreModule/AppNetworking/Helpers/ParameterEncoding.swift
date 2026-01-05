//
//  ParameterEncoding.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws
}

extension ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {}
}

public enum ParameterEncoderError : String, Error {
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest, body: Parameters?, url: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = url else {
                    return
                }
                let urlEncoder: URLParameterEncoderProtocol = resolve()
                try urlEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                guard let urlParameters = url else {
                    return
                }
                let urlEncoder: URLParameterEncoderProtocol = resolve()
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try urlEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
        } catch {
            throw error
        }
    }
    
    public func encode(urlRequest: inout URLRequest, body: [Parameters]?, url: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = url else {
                    return
                }
                let urlEncoder: URLParameterEncoderProtocol = resolve()
                try urlEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = body else {
                    return
                }
                guard let urlParameters = url else {
                    return
                }
                let urlEncoder: URLParameterEncoderProtocol = resolve()
                let jsonEncoder: JSONParameterEncoderProtocol = resolve()
                try urlEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                try jsonEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}
