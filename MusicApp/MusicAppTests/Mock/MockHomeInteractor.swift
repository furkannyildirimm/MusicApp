//
//  MockHomeInteractor.swift
//  MusicAppTests
//
//  Created by STARK on 13.06.2023.
//

import Foundation
@testable import MusicApp

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var fetchMusicCalled = false
    var fetchMusicKeyword: String?
    
    func fetchMusic(with keyword: String) {
        fetchMusicCalled = true
        fetchMusicKeyword = keyword
    }
}
