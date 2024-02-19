//
//  Color+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension UIColor {
    struct appTheme {
        static let background = UIColor(named: "background")!
        static let oceanBlue = UIColor(named: "oceanBlue")!
        static let lightBackground = UIColor(red: 0.23, green: 0.25, blue: 0.28, alpha: 1)
        static let darkGray = UIColor(red: 0.4, green: 0.41, blue: 0.43, alpha: 1)
        static let secondaryText = UIColor(red: 0.93, green: 0.93, blue: 0.92, alpha: 1)
        static let text = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let orange = UIColor(red: 1, green: 0.53, blue: 0, alpha: 1)
    }
    
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
