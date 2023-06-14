//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

import UIKit
import MusicAPI

protocol DetaillPresenterProtocol {
    func viewDidLoad()
    func playAudio()
    func saveMusicDetails(music: MusicDetails)
    func deleteMusicDetails(music: MusicDetails)
}

final class DetaillPresenter {
    
    unowned var view: DetaillViewControllerProtocol!
    let router: DetaillRouterProtocol!
    
    init(
        view: DetaillViewControllerProtocol,
        router: DetaillRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

extension DetaillPresenter: DetaillPresenterProtocol {
    func saveMusicDetails(music: MusicDetails) {
        CoreDataManager.shared.saveMusic(music: music)
    }
    
    func deleteMusicDetails(music: MusicDetails) {
        CoreDataManager.shared.deleteMusic(music: music)
    }
    
    func playAudio() {
        guard let music = view.getSource() else { return }
        guard let previewURLString = music.previewUrl,
              let previewURL = URL(string: previewURLString) else {
            return
        }
        
        let audioManager = AudioManager.shared
        
        if audioManager.isPlaying  {
            audioManager.stop()
        } else {
            audioManager.play(url: previewURL, songName: music.trackName ?? "")
        }
    }
    
    func viewDidLoad() {
        
        guard let music = view.getSource() else { return }
        
        view.setTrackName(music.trackName ?? "")
        view.setArtistName(music.artistName ?? "")
        view.setTrackPrice(music.trackPrice ?? 0)
        view.setCollectionPrice(music.collectionPrice ?? 0)
        view.setPrimaryName(music.primaryGenreName ?? "")
        view.setCollectionName(music.collectionName ?? "")
        if let imageURLString = music.artworkUrl100,
           let imageURL = URL(string: imageURLString) {
            view?.setMusicImage(imageURL)
        }
    }
}
