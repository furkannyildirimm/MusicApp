//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by STARK on 7.06.2023.
//

import UIKit
import MusicAPI
import AVFoundation

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
    func playPauseButtonTapped()
}

final class MusicCellPresenter {
    
    weak var view: MusicCellProtocol?
    private let music: Music
    private var player: AVPlayer?
    
    init(
        view: MusicCellProtocol?,
        music: Music
    ) {
        self.view = view
        self.music = music
    }
    private func configurePlayer(with url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.automaticallyWaitsToMinimizeStalling = false
    }
    
    private func play() {
        player?.play()
    }
    
    private func pause() {
        player?.pause()
    }
    
    
}

extension MusicCellPresenter: MusicCellPresenterProtocol {
    
    func playPauseButtonTapped() {
        guard let previewUrlString = music.previewUrl,
              let previewUrl = URL(string: previewUrlString) else {
            return
        }
        
        if let player = player, let currentItem = player.currentItem, let currentItemUrl = currentItem.asset as? AVURLAsset, currentItemUrl.url == previewUrl {
            if player.timeControlStatus == .playing {
                pause()
            } else {
                play()
            }
        } else {
            configurePlayer(with: previewUrl)
            play()
        }
    }
    
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
