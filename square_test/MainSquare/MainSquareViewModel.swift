//
//  MainSquareViewModel.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

final class MainSquareViewModel: UIFeatureViewModel<MainSquareFeature> {
    
    struct Dependencies {
    }
    
    private let router: MainSquareRouterProtocol
    private let inputData: MainSquareInputData
    private let dependencies: MainSquareViewModel.Dependencies
    
    init(
        state: MainSquareFeature.State,
        router: MainSquareRouterProtocol,
        inputData: MainSquareInputData,
        dependencies: MainSquareViewModel.Dependencies
    ) {
        self.router = router
        self.inputData = inputData
        self.dependencies = dependencies
        super.init(initialState: state)
    }
    
    override func handle(action: MainSquareFeature.Action) {
    }
}
