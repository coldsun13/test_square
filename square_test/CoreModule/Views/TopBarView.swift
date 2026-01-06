//
//  TopBarView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import SwiftUI

struct TopBarView: View {

    let title: String
    let leftIcon: Image?
    let onBack: (() -> Void)?

    var body: some View {
        ZStack {
            HStack {
                if let leftIcon, let onBack {
                    Button(action: onBack) {
                        leftIcon
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                    }
                    .frame(width: 44, height: 44)
                }

                Spacer()
            }

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
    }
}
