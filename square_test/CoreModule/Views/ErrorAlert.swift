//
//  ErrorAlert.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 6.01.26.
//

import UIKit

enum ErrorAlert {

    static func show(
        _ error: Error,
        from viewController: UIViewController,
        title: String = "Error"
    ) {
        let message: String

        if let networkError = error as? NetworkError {
            message = networkError.localizedDescription
        } else {
            message = error.localizedDescription
        }

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        viewController.present(alert, animated: true)
    }
}
