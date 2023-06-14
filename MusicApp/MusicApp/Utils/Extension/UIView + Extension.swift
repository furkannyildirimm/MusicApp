//
//  UIView + Extension.swift
//  MusicApp
//
//  Created by STARK on 7.06.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get{ return self.cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
