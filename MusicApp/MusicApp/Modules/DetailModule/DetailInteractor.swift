//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

protocol DetailInteractorOutputProtocol {
    func fetchMusicDetailOutput(result: MusicSourcesResult)
}

final class DetaillInteractor {
    var output: HomeInteractorOutputProtocol?
}
