//
//  HomeRouter.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import Foundation
import MusicAPI

protocol HomeRouterProtocol {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail (source: Music?)
    case favourites
}

final class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = DetaillRouter.createModule()
            detailVC.presenter.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        case .favourites:
            let favouritesVC = FavouritesRouter.createModule()
            viewController?.navigationController?.pushViewController(favouritesVC, animated: true)
        }
    }
}

