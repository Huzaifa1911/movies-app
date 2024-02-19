//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonDecodingError
    case notFound
    case badRequest
    case unknownError
    case invalidRequest
}
