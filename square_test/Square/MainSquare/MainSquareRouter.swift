//
//  MainSquareRouter.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import UIKit

enum MainSquareRoute {
}

protocol MainSquareRouterProtocol {
    func navigate(to route: MainSquareRoute)
}

final class MainSquareRouter: MainSquareRouterProtocol {
    weak var view: UIViewController?
    
    func navigate(to route: MainSquareRoute) {
    }
}
