//
//  FavouritesViewController.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.register(cellType: FavouriteCell.self)
        CoreDataManager.shared.fetchMusic()
        addCustomBackButton()
        
    }
    private func addCustomBackButton() {
        let backButton = CustomBackButton()
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.fetchMusic().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FavouriteCell.self, for: indexPath)
        cell.selectionStyle = .none
        let music = CoreDataManager.shared.fetchMusic()[indexPath.row]
        cell.configure(with: music)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let musicEntity = CoreDataManager.shared.fetchMusic()[indexPath.row]
            let musicDetails = MusicDetails(artistName: musicEntity.artistName ?? "", collectionName: musicEntity.collectionName ?? "", trackName: musicEntity.trackName ?? "", artworkUrl100: musicEntity.artworkUrl100 ?? "")
            CoreDataManager.shared.deleteMusic(music: musicDetails)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

