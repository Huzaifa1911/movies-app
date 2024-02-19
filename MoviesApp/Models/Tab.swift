//
//  Tab.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 09/02/2024.
//

import UIKit

enum Tab {
    case home
    case search
    case watchlist
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .watchlist:
            return "Watchlist"
        }
    }
    
    var tabIndex: Int {
        switch self {
        case .home:
            return 0
        case .search:
            return 1
        case .watchlist:
            return 2
        }
    }
    
    var tabIcon: UIImage? {
        switch self {
        case .home:
            return .icons.house?.size(of: 14)
        case .search:
            return .icons.magnifyingGlass?.size(of: 14)
        case .watchlist:
            return .icons.bookmark?.size(of: 14)
        }
    }
    
    var color: UIColor {
        .appTheme.text
    }
    
    var selectedColor: UIColor {
        .appTheme.oceanBlue
    }
}
