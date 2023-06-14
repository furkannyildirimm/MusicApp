//
//  FavouritesViewController.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import UIKit

protocol FavouritesView: AnyObject {
    func updateTableView()
}

final class FavouritesViewController: BaseViewController, FavouritesView {
    
    @IBOutlet weak var favouritesTableView: UITableView!
    private var emptyStateImageView: UIImageView!
    var presenter: FavouritesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.register(cellType: FavouriteCell.self)
        presenter?.viewDidLoad()
        addCustomBackButton()
        emptyView()
    }
    
    private func addCustomBackButton() {
        let backButton = CustomBackButton()
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    func updateTableView() {
        favouritesTableView.reloadData()
        checkEmptyState()
    }
    
    private func emptyView(){
        emptyStateImageView = UIImageView(emptyStateImage: UIImage(named: "emptyView")!)
        emptyStateImageView.showEmptyState(in: view)
        favouritesTableView.separatorStyle = .none
        favouritesTableView.tableFooterView = UIView()
        checkEmptyState()
    }
    
    func checkEmptyState() {
        let isEmpty = presenter?.numberOfMusicItems() == 0
        favouritesTableView.separatorStyle = isEmpty ? .none : .none
        
        if isEmpty {
            emptyStateImageView.showEmptyState(in: view)
        } else {
            emptyStateImageView.hideEmptyState()
        }
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfMusicItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FavouriteCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let musicItem = presenter?.musicItem(at: indexPath.row) {
            cell.configure(with: musicItem)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let message = "Are you sure you want to remove from favorites?"
            ConfirmationAlertManager.showConfirmationAlert(from: self, message: message) { confirmed in
                if confirmed {
                    self.presenter?.deleteMusicItem(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    self.checkEmptyState()
                } else {
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}


