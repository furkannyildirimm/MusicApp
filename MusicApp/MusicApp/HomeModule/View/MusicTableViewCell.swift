//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit

protocol MusicCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setTitle(_ text: String)
    func setArtist(_ text: String)
    func setCollection(_ text: String)
}

final class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var collectionTitle: UILabel!
    
    var cellPresenter: MusicCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MusicTableViewCell: MusicCellProtocol {
    
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.musicImage.image = image
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

