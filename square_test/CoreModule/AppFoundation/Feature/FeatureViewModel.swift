//
//  FeatureViewModel.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

class UIFeatureViewModel<Feature: UIFeature> {

    @MainActor var effectClosure: ((Feature.Effect) -> Void)?

    var state: Feature.State { store.state }

    let store: StoreOf<Feature>

    init(initialState state: Feature.State) {
        let store = StoreOf<Feature>(state: state)
        self.store = store

        store.bindActionHandler { [weak self] action in
            guard let self else {
                return
            }
            self.handle(action: action)
        }
    }

    func handle(action: Feature.Action) {
        fatalError("handle(action:) must be overridden in subclass")
    }

    func postEffect(_ effect: Feature.Effect) {
        Task {
            await MainActor.run {
                effectClosure?(effect)
            }
        }
    }
}
