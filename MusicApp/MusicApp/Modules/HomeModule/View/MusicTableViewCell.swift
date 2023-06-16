//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit

protocol MusicCellDelegate: AnyObject {
    func cellReloadData()
}

protocol MusicCellProtocol: AnyObject {
    func setImage(_ url: URL)
    func setTitle(_ text: String)
    func setArtist(_ text: String)
    func setCollection(_ text: String)
    func cellReloadData()
}

final class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var musicImage: UIImageView!
    @IBOutlet private weak var musicTitle: UILabel!
    @IBOutlet private weak var artistTitle: UILabel!
    @IBOutlet private weak var collectionTitle: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    var cellPresenter: MusicCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    weak var delegate: MusicCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIView.animate(withDuration: 0.5) {
            self.center.x += 100
        }
    }
    
    func configureImage(_ trackId: Int) {
        if AudioManager.shared.isPlaying && AudioManager.shared.songName == "\(trackId)"{
            playButton.setImage(UIImage(named:"pauseButtonCell"), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "playButtonCell"), for: .normal)
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        cellPresenter.playButtonTapped()
        playButton.setImage(UIImage(named:AudioManager.shared.isPlaying ? "pauseButtonCell" : "playButtonCell"), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let trackId = Int(musicTitle.text ?? ""), AudioManager.shared.songName == "\(trackId)"{
            playButton.setImage(UIImage(named:AudioManager.shared.isPlaying ? "pauseButtonCell" : "playButtonCell"), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "playButtonCell"), for: .normal)
        }
    }
}

extension MusicTableViewCell: MusicCellProtocol {
    func cellReloadData() {
        delegate?.cellReloadData()
    }
    
    func setImage(_ url: URL) {
        DispatchQueue.main.async {
            self.musicImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    func setTitle(_ text: String) {
        musicTitle.text = text
    }
    
    func setArtist(_ text: String) {
        artistTitle.text = text
    }
    
    func setCollection(_ text: String) {
        collectionTitle.text = text
    }
}

