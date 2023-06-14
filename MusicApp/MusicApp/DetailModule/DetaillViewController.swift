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
    var isMusicSaved: Bool = false
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var primaryName: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardViewTwo: CardView!
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButton()
        presenter.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let isMusicSaved = CoreDataManager.shared.checkIfMusicExists(music: createMusicDetails())
        setHeartButtonImage(isMusicSaved)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isMusicSaved = false
    }
    
    private func setHeartButtonImage(_ isMusicSaved: Bool) {
        let heartImage = isMusicSaved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        saveButton.setImage(heartImage, for: .normal)
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let isMusicSaved = CoreDataManager.shared.checkIfMusicExists(music: createMusicDetails())
        if isMusicSaved {
            ConfirmationAlertManager.showConfirmationAlert(from: self, message: "Favorilerden çıkarmak istediğinize emin misiniz?") { [weak self] confirmed in
                guard let self = self else { return }
                
                if confirmed {
                    CoreDataManager.shared.deleteMusic(music: createMusicDetails())
                    print("Müzik başarıyla silindi.")
                    self.setHeartButtonImage(false)
                }
            }
        } else {
            self.presenter.saveMusicDetails(music: createMusicDetails())
            print("Müzik başarıyla kaydedildi.")
            self.setHeartButtonImage(true)
        }
    }
    
    private func createMusicDetails() -> MusicDetails {
        return MusicDetails(
            artistName: artistName.text ?? "",
            collectionName: collectionName.text ?? "",
            trackName: trackName.text ?? "",
            artworkUrl100: source?.artworkUrl100 ?? "",
            trackId: source?.trackId ?? 0
        )
    }
    
    private func updateTextColorsBasedOnBackground(_ backgroundColor: UIColor?) {
        guard let backgroundColor = backgroundColor else { return }
        let textColor: UIColor = backgroundColor.isLight() ? .black : .white
        artistName.textColor = textColor
        collectionName.textColor = textColor
        trackName.textColor = textColor
        primaryName.textColor = textColor
        trackPrice.textColor = textColor
        collectionPrice.textColor = textColor
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
            let color = self.musicImage.image?.averageColor
            self.cardView.backgroundColor = color
            self.cardViewTwo.backgroundColor = color
            self.updateTextColorsBasedOnBackground(color)
            
        }
    }
    
    func getSource() -> Music? {
        return source
    }
}

