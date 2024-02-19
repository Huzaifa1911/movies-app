//
//  MovieFilter.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 09/02/2024.
//

import Foundation

enum MovieFilter: CaseIterable {
    case nowPlaying
    case upcoming
    case topRated
    case popular
    
    var rawValue: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        }
    }
}
