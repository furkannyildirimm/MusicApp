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
    private var audioPlayer: AVPlayer = AVPlayer()
    var isPlaying: Bool = false
    var songName: String = ""
    
    func play(url: URL, songName: String) {
        
        audioPlayer = AVPlayer(url: url)
        audioPlayer.play()
        isPlaying = true
        self.songName = songName
    }
    
    func stop(){
        audioPlayer.pause()
        isPlaying = false
        songName = ""
    }
}
