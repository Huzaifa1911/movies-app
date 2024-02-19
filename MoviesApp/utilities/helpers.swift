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


func showToast(on controller: UIViewController, with message: String, for duration: Double = 2.0) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
    alert.view.backgroundColor = .appTheme.secondaryText
    alert.view.tintColor = .appTheme.background
    alert.view.layer.cornerRadius = 16
    controller.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
        alert.dismiss(animated: true)
    }
}
