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
        static let bookmarkFill = UIImage(systemName: "bookmark.fill")
        static let photo = UIImage(systemName: "photo")
        static let calendar = UIImage(systemName: "calendar")
        static let clock = UIImage(systemName: "clock")
        static let ticket = UIImage(systemName: "ticket")
        static let chevronLeft = UIImage(systemName: "chevron.left")
        static let star = UIImage(systemName: "star")
        static let xmark = UIImage(systemName: "xmark")
        static let noResult = UIImage(named: "noResult")
        static let magicBox = UIImage(named: "magicBox")
        static let avatar = UIImage(named: "avatar")
       
    }
    
    // only used for SF symbols
    func size(of pointSize: CGFloat) -> UIImage? {
        self.applyingSymbolConfiguration(.init(pointSize: pointSize))
    }
}
