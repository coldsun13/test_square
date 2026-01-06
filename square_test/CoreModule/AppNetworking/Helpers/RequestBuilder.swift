//
//  RequestBuilder.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

protocol RequestBuilderProtocol {
    func buildRequest(from route: EndPointType) throws -> URLRequest
}

class RequestBuilder: RequestBuilderProtocol {
    func buildRequest(from route: EndPointType) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: route.requestTimeout
        )

        request.httpMethod = route.httpMethod.rawValue

        let allHeaders = route.includeDefaultHeaders
            ? HTTPHeader.defaultHeaders + route.requestHeaders
            : route.requestHeaders
        
        allHeaders.forEach {
            request.setValue($0.value.headerValue, forHTTPHeaderField: $0.key)
        }

        do {
            switch route.task {
            case .request:
                break
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):

                try configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request
                )

            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):

                Self.addAdditionalHeaders(additionalHeaders.or([]), request: &request)
                try configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request
                )

            case .requestParametersAsArrayAndHeaders(let bodyParameters,
                                                     let bodyEncoding,
                                                     let urlParameters,
                                                     let additionalHeaders):
                Self.addAdditionalHeaders(additionalHeaders.or([]), request: &request)
                try configureParameters(
                    bodyParameters: bodyParameters.or([]),
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request
                )

            case .requestDataParametersAndHeaders(let jsonDataParameters,
                                                  let urlParameters,
                                                  let additionalHeaders):
                Self.addAdditionalHeaders(additionalHeaders.or([]), request: &request)
                try configureParameters(
                    jsonDataParameters: jsonDataParameters,
                    urlParameters: urlParameters,
                    request: &request
                )
            }
            return request
            
        } catch {
            throw error
        }
    }

    private func configureParameters(
        jsonDataParameters: Data,
        urlParameters: Parameters?,
        request: inout URLRequest
    ) throws {
        let jsonEncoder: JSONParameterEncoderProtocol = resolve()
        try jsonEncoder.encode(urlRequest: &request, with: jsonDataParameters)
    }

    private func configureParameters(
        bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        request: inout URLRequest
    ) throws {
        do {
            try bodyEncoding.encode(
                urlRequest: &request,
                body: bodyParameters,
                url: urlParameters
            )
        } catch {
            throw error
        }
    }

    private func configureParameters(
        bodyParameters: [Parameters],
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        request: inout URLRequest
    ) throws {
        do {
            try bodyEncoding.encode(
                urlRequest: &request,
                body: bodyParameters,
                url: urlParameters
            )
        } catch {
            throw error
        }
    }

    static func addAdditionalHeaders(
        _ additionalHeaders: [HTTPHeader],
        request: inout URLRequest
    ) {
        for header in additionalHeaders {
            request.setValue(
                header.value.headerValue,
                forHTTPHeaderField: header.key
            )
        }
    }
}
