//
//  MovieDetailsAttribute.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import Foundation

enum MovieDetailsAttribute: CaseIterable {
    case about
    case reviews
    case cast
    
    var rawValue: String {
        switch self {
        case .about:
            return "About Movie"
        case .reviews:
            return "Reviews"
        case .cast:
            return "Cast"
        }
    }
}
