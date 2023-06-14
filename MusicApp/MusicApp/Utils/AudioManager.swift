//
//  AudioManager.swift
//  MusicApp
//
//  Created by STARK on 9.06.2023.
//

import Foundation
import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    
    var audioPlayer: AVPlayer?
    var isPlaying: Bool = false
    var songName: String = ""
    var lastPlaybackTime: CMTime = .zero
    var currentURL: URL?
    
    func play(url: URL, songName: String) {
        if let currentURL = currentURL, currentURL == url {
            if !isPlaying {
                audioPlayer?.play()
                isPlaying = true
                return
            }
        }
        stop()
        audioPlayer = AVPlayer(url: url)
        self.songName = songName
        currentURL = url
        audioPlayer?.play()
        isPlaying = true
    }
    
    func stop() {
        audioPlayer?.pause()
        isPlaying = false
        guard let currentTime = audioPlayer?.currentTime() else { return }
        lastPlaybackTime = currentTime
    }
}

