//
//  HomeViewController.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showError(_ message: String)
    func showLoadingView()
    func hideLoadingView()
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        presenter.viewDidLoad()
        addCustomRightButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    private func addCustomRightButton() {
        let rightButton = CustomRightButton()
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightButtonItem
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func setupTableView() {
        tableView.register(cellType: MusicTableViewCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        showAlert("Error", message)
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: MusicTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.delegate = self
        if let music = presenter.music(indexPath.row) {
            cell.cellPresenter = MusicCellPresenter(view: cell, music: music)
        }
        cell.configureImage(presenter.music(indexPath.row)?.trackName ?? "")
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
        AudioManager.shared.stop()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false, block: { [weak self] _ in
            self?.performSearch(with: searchText)
        })
    }
    
    private func performSearch(with keyword: String) {
        guard !keyword.isEmpty else {
            presenter.clearSearchResults()
            return
        }
        presenter.searchMusic(with: keyword)
    }
}

extension HomeViewController: MusicCellDelegate {
    func cellReloadData(){
        tableView.reloadData()
    }
}
