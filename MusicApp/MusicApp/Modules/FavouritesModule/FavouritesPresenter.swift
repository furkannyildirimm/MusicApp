//
//  FavouritesPresenter.swift
//  MusicApp
//
//  Created by STARK on 12.06.2023.
//

import Foundation

protocol FavouritesPresenterProtocol {
    func viewDidLoad()
    func numberOfMusicItems() -> Int
    func musicItem(at index: Int) -> MusicDetails?
    func deleteMusicItem(at index: Int)
}

final class FavouritesPresenter: FavouritesPresenterProtocol {
    
    weak var view: FavouritesView?
    var interactor: FavouritesInteractorProtocol
    var router: FavouritesRouterProtocol
    
    init(view: FavouritesView, interactor: FavouritesInteractorProtocol, router: FavouritesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var musicItems: [MusicDetails] = []
    
    func viewDidLoad() {
        interactor.fetchMusicItems()
    }
    
    func numberOfMusicItems() -> Int {
        return musicItems.count
    }
    
    func musicItem(at index: Int) -> MusicDetails? {
        
        guard index >= 0 && index < musicItems.count else {
            return nil
        }
        return musicItems[index]
    }
    
    func deleteMusicItem(at index: Int) {
        
        guard index >= 0 && index < musicItems.count else {
            return
        }
        let musicItem = musicItems[index]
        interactor.deleteMusicItem(music: musicItem)
        interactor.fetchMusicItems()
    }
}

extension FavouritesPresenter: FavouritesInteractorOutput {
    
    func fetchMusic(musicModel: [MusicDetails]) {
        self.musicItems = musicModel
    }
}

