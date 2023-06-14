//
//  FavouritesRouter.swift
//  MusicApp
//
//  Created by STARK on 12.06.2023.
//

import UIKit

final class FavouritesRouter {
    weak var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let viewController = FavouritesViewController()
        let interactor = FavouritesInteractor(dataManager: CoreDataManager.shared)
        let router = FavouritesRouter()
        let presenter = FavouritesPresenter(view: viewController, interactor: interactor)
        interactor.output = presenter
        viewController.presenter = presenter
        router.view = viewController
        
        return viewController
    }
}
