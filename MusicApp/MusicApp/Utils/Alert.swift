//
//  Alert.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import UIKit

class ConfirmationAlertManager {
    static func showConfirmationAlert(from viewController: UIViewController, message: String, completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
            completion(false)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
