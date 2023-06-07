//
//  HomeInteractor.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import Foundation
import MusicAPI

typealias MusicSourcesResult = Result<[Music], Error>

protocol HomeInteractorProtocol: AnyObject {
    func fetchMusic()
}

protocol HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: MusicSourcesResult)
}

fileprivate var musicService: MusicServiceProtocol = MusicService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusic() {
        musicService.fetchMusicEntries(word: "tarkan") { [weak self] result in
            guard let self else { return }
            self.output?.fetchMusicOutput(result)
        }
    }
    
}
