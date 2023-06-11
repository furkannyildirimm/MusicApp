//
//  CustomBackButton.swift
//  MusicApp
//
//  Created by STARK on 10.06.2023.
//


import UIKit

final class CustomBackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setImage(UIImage(named: "left-arrow"), for: .normal)
        addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        setTitle("Back", for: .normal)
        setTitleColor(.black, for: .normal)
    }
    
    @objc private func backButtonTapped() {
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }
}

import UIKit

final class CustomRightButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setTitle("Favourites", for: .normal)
        setTitleColor(.black, for: .normal)
        setImage(UIImage(named: "library"), for: .normal)
        addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc private func rightButtonTapped() {
        
          let destinationVC = FavouritesViewController()
          if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
              navigationController.pushViewController(destinationVC, animated: true)
          }
    }
}

