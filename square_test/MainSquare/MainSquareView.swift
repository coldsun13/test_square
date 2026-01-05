//
//  MainSquareView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import SwiftUI

final class MainSquareViewState: UIFeatureState {
}

enum MainSquareAction: UIFeatureAction {
}

struct MainSquareView: View {
    @ObservedObject var store: StoreOf<MainSquareFeature>
    var body: some View {
        Text("руддвцвцв")
    }
}
