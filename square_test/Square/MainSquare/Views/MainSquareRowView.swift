//
//  MainSquareRowView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import SwiftUI

struct MainSquareRepoRowView: View {
    let item: MainSquareRepoViewItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.title)
                .font(.headline)
                .accessibilityIdentifier("repo_title_\(item.id)")
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
