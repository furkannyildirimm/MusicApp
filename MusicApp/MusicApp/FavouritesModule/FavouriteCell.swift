//
//  FavouriteCell.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import UIKit
import SDWebImage

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configure(with music: MusicEntity) {
            artistName?.text = music.artistName
            detail?.text = "\(music.trackName ?? "") - \(music.collectionName ?? "")"
        
        if let imageURLString = music.artworkUrl100,
                   let imageURL = URL(string: imageURLString) {
                    musicImage.sd_setImage(with: imageURL, completed: nil)
                }
        }
    
}
