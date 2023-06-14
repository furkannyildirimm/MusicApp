//
//  DetailRouter.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

final class DetaillRouter {
    weak var viewController: DetaillViewController?
    
    static func createModule() -> DetaillViewController {
        let view = DetaillViewController()
        let router = DetaillRouter()
        let presenter = DetaillPresenter(view: view)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

