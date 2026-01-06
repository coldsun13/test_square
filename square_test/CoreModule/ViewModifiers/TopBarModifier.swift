//
//  TopBarModifier.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import SwiftUI

struct TopBarModifier: ViewModifier {

    let title: String
    let leftIcon: Image?
    let onBack: (() -> Void)?

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            TopBarView(
                title: title,
                leftIcon: leftIcon,
                onBack: onBack
            )

            Divider()

            content
        }
    }
}
