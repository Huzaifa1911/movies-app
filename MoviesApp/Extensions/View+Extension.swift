//
//  View+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension UIView {
    func setFont(font: Poppins = .regular, size: CGFloat = 14, color: UIColor = .appTheme.text) {
        let font = poppins(font: font, size: size)
        
        switch self {
        case let label as UILabel:
            label.font = UIFontMetrics.default.scaledFont(for: font)
            label.textColor = color
            label.adjustsFontForContentSizeCategory = true
            
        case let field as UITextField:
            field.font = UIFontMetrics.default.scaledFont(for: font)
            field.textColor = color
            field.adjustsFontForContentSizeCategory = true
            
        case let navigationBar as UINavigationBar:
            navigationBar.titleTextAttributes = [
                .foregroundColor: color as UIColor,
                .font: font
            ]
        default:
            break
        }
    }
}
