//
//  SplashInteractor.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import Foundation

protocol SplashInteractorProtocol {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = Reachability.isConnectedToNetwork()
        self.output?.internetConnection(status: internetStatus)
    }
   
}
