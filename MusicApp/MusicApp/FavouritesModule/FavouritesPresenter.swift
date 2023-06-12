//
//  FavouritesPresenter.swift
//  MusicApp
//
//  Created by STARK on 12.06.2023.
//

//protocol FavouritesPresenterProtocol: AnyObject {
//    func viewDidLoad()
//    func numberOfItems() -> Int
//    //func music(_ index: Int) -> Music? // ???
//    //func didSelectRowAt(index: Int)
//}
//
//final class FavouritesPresenter {
//    unowned var view: FavouritesViewControllerProtocol
//    let router: FavouritesRouterProtocol!
//    let interactor: FavouritesInteractorProtocol!
//    
//    private var musicDetails: [MusicDetails] = []
//    
//    init(
//        view: FavouritesViewControllerProtocol,
//        router: FavouritesRouterProtocol!,
//        interactor: FavouritesInteractorProtocol!
//    ) {
//        self.view = view
//        self.router = router
//        self.interactor = interactor
//    }
//}
//
//extension FavouritesPresenter: FavouritesPresenterProtocol {
//    func viewDidLoad() {
//        view.setupTableView()
//    }
//    
//    func numberOfItems() -> Int {
//        CoreDataManager.shared.fetchMusic().count
//    }
//    
//    
//}
