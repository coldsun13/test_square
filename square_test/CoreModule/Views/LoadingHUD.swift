//
//  LoadingOverlayView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import UIKit

enum LoadingHUD {

    private static var overlay: UIView?

    static func show() {
        guard overlay == nil else { return }
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first(where: { $0.isKeyWindow })
        else { return }

        let overlayView = UIView(frame: window.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = overlayView.center
        indicator.startAnimating()

        overlayView.addSubview(indicator)
        window.addSubview(overlayView)

        overlay = overlayView
    }

    static func hide() {
        overlay?.removeFromSuperview()
        overlay = nil
    }
}
