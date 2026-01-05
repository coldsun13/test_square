//
//  MainSquareHostController.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

// MARK: - Side effects

enum MainSquareSideEffect: UISideEffect {
    case loading(Bool)
}

// MARK: - Feature Definition

typealias MainSquareFeature = UIFeatureDefinition<
    MainSquareViewState,
    MainSquareAction,
    MainSquareSideEffect
>

// MARK: - Controller

final class MainSquareHostController: UIFeatureController<MainSquareFeature, MainSquareView> {
    
    override func handleEffect(_ effect: MainSquareSideEffect) {
        switch effect {
        case .loading(let isLoading):
            if isLoading {
//                ProgressUI.show()
            } else {
//                ProgressUI.dismiss()
            }
        }
    }
}
