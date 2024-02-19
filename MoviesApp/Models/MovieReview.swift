//
//  MovieReview.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import Foundation

// MARK: - Movie Review Model
struct MovieReview: Decodable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Decodable {
    let name, username: String
    let avatarPath: String?
    let rating: Int?
    
    var avatarUrl: String {
        guard let path = self.avatarPath else { return "" }
        return "\(TMDBConstants.imageBaseUrl)\(path)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

// MARK: - MovieReviewsResponse Model
struct MovieReviewsResponse: Decodable {
    let page: Int
    let id: Int
    let results: [MovieReview]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case id
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
