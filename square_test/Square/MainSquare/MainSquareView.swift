//
//  MainSquareView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import SwiftUI

final class MainSquareViewState: UIFeatureState {
    @Published var items: [MainSquareRepoViewItem] = []
}

enum MainSquareAction: UIFeatureAction {
    case fetchData
}

struct MainSquareView: View {
    @ObservedObject var store: StoreOf<MainSquareFeature>

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.state.items) { item in
                        MainSquareRepoRowView(item: item)
                        Divider()
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Square Repos")
        }
        .onAppear {
            store.send(.fetchData)
        }
    }
}
