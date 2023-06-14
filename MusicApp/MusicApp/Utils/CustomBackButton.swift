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
        setTitleColor(.black, for: .normal)
    }
    
    @objc private func backButtonTapped() {
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
            AudioManager.shared.stop()
        }
    }
}

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
        setTitle("Library", for: .normal)
        setTitleColor(.black, for: .normal)
        if let image = UIImage(systemName: "list.dash")?.withRenderingMode(.alwaysTemplate) {
                setImage(image, for: .normal)
                tintColor = .black
            }
    }
}

