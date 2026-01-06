//
//  LoadingOverlayView.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import UIKit

enum LoadingHUD {

    private static var overlay: UIView?

    static func show(on view: UIView) {
        guard overlay == nil else { return }

        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = overlayView.center
        indicator.startAnimating()

        overlayView.addSubview(indicator)
        view.addSubview(overlayView)

        overlay = overlayView
    }

    static func hide() {
        overlay?.removeFromSuperview()
        overlay = nil
    }
}
