//
//  LoggingProvider.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

protocol Logger: AnyObject {
    func log(_ items: Any...)
}

protocol ConsoleLogger: AnyObject {
    func log(_ text: String)
}

protocol ExternalRequestLogger: AnyObject {
    func logHttpCall(
        url: String,
        method: String?,
        statusCode: Int?,
        duration: TimeInterval,
        success: Bool,
        requestSize: Int?,
        responseSize: Int?,
        errorCode: String?,
        message: String?,
        detail: String?,
        type: String?
    )
}

enum DebugLogger {
    static func log(_ items: Any...) {
        let logger: Logger = resolve()
        logger.log(items)
    }
}

enum DebugConsoleLogger {
    static func log(_ text: String) {
        let logger: ConsoleLogger = resolve()
        logger.log(text)
    }
}
