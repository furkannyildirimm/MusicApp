//
//  BaseViewController.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import UIKit

class BaseViewController: UIViewController, LoadingShowable{

    func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
