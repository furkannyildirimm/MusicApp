//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

import Foundation

//Detay sayfasında veri çekilmeyecekse bu protocol tanımlanmayabilir
protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol {
    func fetchMusicDetailOutput(result: MusicSourcesResult)
}


final class DetaillInteractor {
    var output: HomeInteractorOutputProtocol?
}
