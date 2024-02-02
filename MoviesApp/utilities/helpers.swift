//
//  helpers.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit


func poppins(font: Poppins = .regular, size: CGFloat = 14) -> UIFont {
    guard let customFont = UIFont(name: font.fontName, size: size) else {
        fatalError("""
                Failed to load the \(font.fontName) font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
        )
    }
    return customFont
}
