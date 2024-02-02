//
//  BarItem+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension UIBarItem {
    
    func setFont(font: Poppins = .regular, size: CGFloat = 14, color: UIColor = .appTheme.text, selectedColor: UIColor) {
        
        setTitleTextAttributes([
            .foregroundColor: color,
            .font: poppins(font: font, size: size)
        ], for: .normal)
        
        setTitleTextAttributes([
            .foregroundColor: selectedColor,
            .font: poppins(font: font, size: size)
        ], for: .selected)
    }
}


