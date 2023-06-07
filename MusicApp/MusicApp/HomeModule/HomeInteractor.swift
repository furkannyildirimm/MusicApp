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
    func fetchMusic(with keyword: String)
}

protocol HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: MusicSourcesResult)
}

fileprivate var musicService: MusicServiceProtocol = MusicService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusic(with keyword: String) {
        musicService.fetchMusicEntries(word: keyword) { [weak self] result in
            guard let self else { return }
            self.output?.fetchMusicOutput(result)
        }
    }
    
}
