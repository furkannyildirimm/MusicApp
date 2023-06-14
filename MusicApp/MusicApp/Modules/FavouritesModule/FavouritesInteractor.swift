//
//  FavouritesInteractor.swift
//  MusicApp
//
//  Created by STARK on 12.06.2023.
//

import Foundation

protocol FavouritesInteractorProtocol {
    func fetchMusicItems()
    func deleteMusicItem(music: MusicDetails)
}

protocol FavouritesInteractorOutput: AnyObject {
    func fetchMusic(musicModel: [MusicDetails])
}

final class FavouritesInteractor: FavouritesInteractorProtocol {
    
    var output: FavouritesInteractorOutput!
    var dataManager: CoreDataManagerProtocol
    var musicmodel: [MusicDetails] = []
    init(dataManager: CoreDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchMusicItems()  {
        musicmodel = []
        
        for result in dataManager.fetchMusic() {
            musicmodel.append(MusicDetails(artistName: result.artistName , collectionName: result.collectionName , trackName: result.trackName , artworkUrl100: result.artworkUrl100 , trackId: result.trackId ))
        }
        output.fetchMusic(musicModel: musicmodel)
    }
    
    func deleteMusicItem(music: MusicDetails) {
        dataManager.deleteMusic(music: music)
    }
}
