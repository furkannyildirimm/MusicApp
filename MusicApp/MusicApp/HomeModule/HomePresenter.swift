//
//  HomePresenter.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import Foundation
import MusicAPI

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func music(_ index: Int) -> Music? // ???
    func didSelectRowAt(index: Int)
    func searchMusic(with keyword: String)
    func clearSearchResults()
    func navigateToFavourites()
}


final class HomePresenter {
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var music: [Music] = []
    
    init(
        view: HomeViewControllerProtocol,
        router: HomeRouterProtocol!,
        interactor: HomeInteractorProtocol!
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func navigateToFavourites() {
        router.navigate(.favourites)
    }
    
    func clearSearchResults() {
        music = [] // Arama sonuçlarını temizle
        view.reloadData()
    }
    
    
    func searchMusic(with keyword: String) {
        view.showLoadingView()
        interactor.fetchMusic(with: keyword)
    }
    
    func viewDidLoad() {
        view.setupTableView()
        fetchMusic() // sadsdadsadsadsasda
    }
    
    func numberOfItems() -> Int {
        music.count
    }
    
    func music(_ index: Int) -> Music? {
        return music[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = music(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    private func fetchMusic() {
        //view.showLoadingView()
        //interactor.fetchMusic()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: MusicSourcesResult) {
        view.hideLoadingView()
        switch result {
                  case .success(let response):
                      self.music = response
                      view.reloadData()
                  case .failure(let error):
                      view.showError(error.localizedDescription)
              }
    }
}
