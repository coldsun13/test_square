//
//  MainSquareContainerView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import SwiftUI

struct MainSquareContainerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        MainSquareBuilder(
            inputData: MainSquareInputData()
        ).build()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) { }
}
