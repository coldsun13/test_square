//
//  RepositoryModel.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import Foundation

struct RepositoryModel {
    struct Response: Decodable {
        let id: Int
        let name: String
        let description: String?
    }
}
