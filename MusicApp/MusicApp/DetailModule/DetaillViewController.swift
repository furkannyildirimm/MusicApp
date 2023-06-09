//
//  DetaillViewController.swift
//  MusicApp
//
//  Created by STARK on 8.06.2023.
//

import UIKit
import MusicAPI

protocol DetaillViewControllerProtocol: AnyObject {
    func setArtistName(_ text: String)
    func setCollectionName(_ text: String)
    func setTrackName(_ text: String)
    func setPrimaryName(_ text: String)
    func setTrackPrice(_ num: Double)
    func setCollectionPrice(_ num: Double)
    func setMusicImage(_ url: URL)
    func getSource() -> Music?
    func playAudio()
}

class DetaillViewController: BaseViewController {
    
    var presenter: DetaillPresenterProtocol!
    var source: Music?
    
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var primaryName: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButton()
        presenter.viewDidLoad()

    }
    
    @IBAction func playButton(_ sender: Any) {
        presenter.playAudio()
        playButton.setImage(UIImage(named:AudioManager.shared.isPlaying ? "pauseButtonDetail" : "playButtonDetail"), for: .normal)
    }
    
    private func addCustomBackButton() {
        let backButton = CustomBackButton()
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
}

extension DetaillViewController: DetaillViewControllerProtocol {
    
    func playAudio() {
        presenter.playAudio()
    }
    
    func setArtistName(_ text: String) {
        artistName.text = text
    }
    
    func setCollectionName(_ text: String) {
        collectionName.text = text
    }
    
    func setTrackName(_ text: String) {
        trackName.text = text
    }
    
    func setPrimaryName(_ text: String) {
        primaryName.text = text
    }
    
    func setTrackPrice(_ num: Double) {
        trackPrice.text = "Track Price: \(num) $"
    }
    
    func setCollectionPrice(_ num: Double) {
        collectionPrice.text = "Collection Price \(num) $"
    }
    
    func setMusicImage(_ url: URL) {
        DispatchQueue.main.async {
                self.musicImage.sd_setImage(with: url, completed: nil)
            }
    }
    
    func getSource() -> Music? {
        return source
    }
}

