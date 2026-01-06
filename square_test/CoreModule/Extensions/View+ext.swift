//
//  View+ext.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import SwiftUI

extension View {
    
    func onFirstAppear(action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
    
    func onFirstTask(action: @escaping () async -> Void) -> some View {
        modifier(OnFirstTaskViewModifier(action: action))
    }
    
    func topBar(
        title: String,
        leftIcon: Image? = nil,
        onBack: (() -> Void)? = nil
    ) -> some View {
        modifier(
            TopBarModifier(
                title: title,
                leftIcon: leftIcon,
                onBack: onBack
            )
        )
    }
}
