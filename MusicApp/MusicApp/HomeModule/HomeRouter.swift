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
}

final class HomeRouter {
    
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

    
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        
    }
    
    
//    func navigate(_ route: HomeRoutes) {
//        switch route {
//        case .detail(let source):
//
//            let detailVC = DetailRouter.createModule()
//            detailVC.source = source
//            viewController?.navigationController?.pushViewController(detailVC, animated: true)
//        }
//    }
    
}
