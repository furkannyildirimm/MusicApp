//
//  SplashViewController.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: BaseViewController {

    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()
        
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlert("Error", "No internet")
        
    }
    
}
