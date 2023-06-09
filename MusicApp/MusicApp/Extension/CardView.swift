//
//  CardView.swift
//  MusicApp
//
//  Created by STARK on 7.06.2023.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        cornerRadius = 10
    }
}

//class CardViewTwo: CardView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupShadow()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        setupShadow()
//    }
//
//     private func setupShadow() {
//        layer.shadowColor = UIColor.green.cgColor
//        layer.shadowOffset = CGSize(width: 4, height: 4)
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 10
//        layer.cornerRadius = 15
//    }
//}
