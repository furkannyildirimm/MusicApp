//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit
import SDWebImage

protocol MusicCellProtocol: AnyObject {
    func setImage(_ url: URL)
    func setTitle(_ text: String)
    func setArtist(_ text: String)
    func setCollection(_ text: String)
}

final class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var cellPresenter: MusicCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIView.animate(withDuration: 0.5) {
            self.center.x += 100
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MusicTableViewCell: MusicCellProtocol {
    
    
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

