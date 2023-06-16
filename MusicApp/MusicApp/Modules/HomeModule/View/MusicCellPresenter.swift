//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by STARK on 7.06.2023.
//

import Foundation
import MusicAPI

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
    func playButtonTapped()
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
    
    func playButtonTapped() {
        guard let previewURLString = music.previewUrl,
              let previewURL = URL(string: previewURLString) else {
            return
        }
        
        let audioManager = AudioManager.shared
        
        if audioManager.isPlaying && audioManager.songName == "\(music.trackId ?? 0)" {
            audioManager.stop()
        } else {
            audioManager.play(url: previewURL, songName: "\(music.trackId ?? 0)")
            view?.cellReloadData()
        }
    }
}
