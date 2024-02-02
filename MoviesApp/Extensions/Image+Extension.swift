//
//  Image+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension UIImage {
    struct icons {
        static let house = UIImage(systemName: "house")
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let bookmark = UIImage(systemName: "bookmark")
    }
    
    // only used for SF symbols
    func setSize(of pointSize: CGFloat) -> UIImage? {
        self.applyingSymbolConfiguration(.init(pointSize: pointSize))
    }
}
