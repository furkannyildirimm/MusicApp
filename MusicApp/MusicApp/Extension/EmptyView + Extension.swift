//
//  EmptyView + Extension.swift
//  MusicApp
//
//  Created by STARK on 14.06.2023.
//

import UIKit

extension UIImageView {
    convenience init(emptyStateImage: UIImage) {
        self.init(image: emptyStateImage)
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showEmptyState(in view: UIView) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func hideEmptyState() {
        removeFromSuperview()
    }
}
