//
//  MainSquareBuilder.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import UIKit
import SwiftUI

// MARK: - MainSquare input

struct MainSquareInputData {
}

// MARK: - MainSquare builder

struct MainSquareBuilder {
    private let inputData: MainSquareInputData
    
    init(inputData: MainSquareInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = MainSquareRouter()
        let viewModel = MainSquareViewModel(
            state: .init(),
            router: router,
            inputData: inputData,
            dependencies: .init(networkService: resolve())
        )
        
        let controller = MainSquareHostController(
            viewModel: viewModel
        ) { store in
            MainSquareView(store: store)
        }
        
        router.view = controller
        return controller
    }
}
