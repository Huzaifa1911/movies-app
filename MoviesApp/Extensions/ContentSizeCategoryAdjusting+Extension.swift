//
//  ContentSizeCategoryAdjusting+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension UIContentSizeCategoryAdjusting {
    func poppins(font: Poppins = .regular, size: CGFloat = 14, color: UIColor? = .appTheme.text) {
        guard let customFont = UIFont(name: font.fontName, size: size) else {
            fatalError("""
                    Failed to load the \(font.fontName) font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
            )
        }
        
        switch self {
        case let label as UILabel:
            label.font = UIFontMetrics.default.scaledFont(for: customFont)
            label.textColor = color
            label.adjustsFontForContentSizeCategory = true
        case let field as UITextField:
            field.font = UIFontMetrics.default.scaledFont(for: customFont)
            field.textColor = color
            field.adjustsFontForContentSizeCategory = true
        default:
            break
        }
    }
}
