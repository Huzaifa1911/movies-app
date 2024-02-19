//
//  PostSuccessResponse.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 15/02/2024.
//

import Foundation

struct PostSuccessResponse: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
