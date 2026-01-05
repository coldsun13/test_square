//
//  FeatureController.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import SwiftUI

class UIFeatureController<Feature: UIFeature, Content: View>: UIHostingController<Content> {

    let viewModel: UIFeatureViewModel<Feature>
    let store: StoreOf<Feature>

    init(
        viewModel: UIFeatureViewModel<Feature>,
        @ViewBuilder content: @escaping (StoreOf<Feature>) -> Content
    ) {
        self.viewModel = viewModel
        self.store = viewModel.store
        super.init(rootView: content(viewModel.store))

        self.viewModel.effectClosure = { [weak self] effect in
            guard let self else {
                return
            }
            self.handleEffect(effect)
        }
    }

    @MainActor required dynamic public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @MainActor
    func handleEffect(_ effect: Feature.Effect) {
    }
}
