//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by STARK on 7.06.2023.
//

import UIKit
import MusicAPI

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
}

final class MusicCellPresenter {
    
    weak var view: MusicCellProtocol?
    private let music: Music
    
    init(
        view: MusicCellProtocol?,
        music: Music
    ) {
        self.view = view
        self.music = music
    }
    
}

extension MusicCellPresenter: MusicCellPresenterProtocol {
    func load() {
        
        view?.setTitle(music.trackName ?? "")
        view?.setArtist(music.artistName ?? "")
        view?.setCollection(music.collectionName ?? "")
        if let imageURLString = music.artworkUrl100,
           let imageURL = URL(string: imageURLString) {
            view?.setImage(imageURL)
        }
    }
}
