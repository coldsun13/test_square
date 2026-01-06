//
//  Cancellable.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

protocol Cancellable {
    var isCompleted: Bool { get }
    func cancel()
}

extension URLSessionTask: Cancellable {
    var isCompleted: Bool {
        state == .completed || state == .canceling
    }
}
