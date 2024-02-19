//
//  Label+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit

extension UILabel {
    func setStrokeText(text: String, color: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor: strokeColor,
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.strokeWidth: -strokeWidth,
            NSAttributedString.Key.font: self.font!
        ]
        self.attributedText = .init(string: text, attributes: strokeTextAttributes)
    }
}
