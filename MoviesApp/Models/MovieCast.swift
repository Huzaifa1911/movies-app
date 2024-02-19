//
//  MovieCast.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import Foundation

struct MovieCast: Decodable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character, creditID: String
    let order: Int
    
    var profileUrl: String {
        guard let path = self.profilePath else { return "" }
        return "\(TMDBConstants.imageBaseUrl)\(path)"
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

// MARK: Movie Cast Response Model

struct MovieCastResponse: Decodable {
    let id: Int
    let cast: [MovieCast]
}
