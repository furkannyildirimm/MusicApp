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

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    private var isEmpty: Bool = true
    private var emptyStateImageView: UIImageView!
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        presenter.viewDidLoad()
        addCustomRightButton()
        emptyView()
        hiddenKeyboard()
    }
    
    func hiddenKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func addCustomRightButton() {
        let rightButton = CustomRightButton()
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightButtonItem
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc private func rightButtonTapped() {
        presenter.navigateToFavourites()
    }
    
    private func emptyView(){
        emptyStateImageView = UIImageView(emptyStateImage: UIImage(named: "emptyView")!)
        emptyStateImageView.showEmptyState(in: view)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
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
            self.checkEmptyState()
        }
    }
    
    func showError(_ message: String) {
        showAlert("Error", message)
    }
    
    func showLoadingView() {
        showLoading()
        checkEmptyState()
    }
    
    func hideLoadingView() {
        hideLoading()
        checkEmptyState()
    }
    
    func checkEmptyState() {
        let isEmpty = presenter.numberOfItems() == 0
        self.isEmpty = isEmpty
        tableView.separatorStyle = isEmpty ? .none : .none
        
        if isEmpty {
            emptyStateImageView.showEmptyState(in: view)
        } else {
            emptyStateImageView.hideEmptyState()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = presenter.numberOfItems()
        checkEmptyState()
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: MusicTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.delegate = self
        if let music = presenter.music(indexPath.row) {
            cell.cellPresenter = MusicCellPresenter(view: cell, music: music)
        }
        cell.configureImage(presenter.music(indexPath.row)?.trackId ?? 0)
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
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
        checkEmptyState()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.clearSearchResults()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}

extension HomeViewController: MusicCellDelegate {
    func cellReloadData(){
        tableView.reloadData()
    }
}
