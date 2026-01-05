//
//  HTTPTask.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

public enum HTTPTask {
    
    case request
    
    case requestParameters(
        bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?
    )
    
    case requestParametersAndHeaders(
        bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: [HTTPHeader]?
    )
    
    case requestParametersAsArrayAndHeaders(
        bodyParameters: [Parameters]?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: [HTTPHeader]?
    )

    case requestDataParametersAndHeaders(
        jsonDataParameters: Data,
        urlParameters: Parameters?,
        additionalHeaders: [HTTPHeader]?
    )
}
