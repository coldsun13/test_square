//
//  Optional+ext.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

extension Optional where Wrapped == String {
    /// Returns self if self is not nil, or empty string
    var orEmpty: String {
        self.or(.init())
    }
}

extension Optional {
    /// Returns self if not nil or passed value
    /// - Parameter value: fallback value
    /// - Returns: self or fallback value
    func or(_ value: Wrapped) -> Wrapped {
        self ?? value
    }
}
