//
//  DetailRouter.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

import Foundation


protocol DetaillRouterProtocol {
    func navigate(_ route: DetaillRoutes)
}

enum DetaillRoutes {
}

final class DetaillRouter {
    weak var viewController: DetaillViewController?
    
    static func createModule() -> DetaillViewController {
        let view = DetaillViewController()
        let router = DetaillRouter()
        let presenter = DetaillPresenter(view: view, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension DetaillRouter: DetaillRouterProtocol {
    func navigate(_ route: DetaillRoutes) {
    }
}
