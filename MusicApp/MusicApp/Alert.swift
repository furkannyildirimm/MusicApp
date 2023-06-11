//
//  Alert.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import UIKit

class ConfirmationAlertManager {
    static func showConfirmationAlert(from viewController: UIViewController, message: String, completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Onay", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Evet", style: .default) { _ in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel) { _ in
            completion(false)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
