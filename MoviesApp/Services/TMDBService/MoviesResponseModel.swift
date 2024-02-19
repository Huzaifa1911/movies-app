//
//  TMDMResponseModel.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 06/02/2024.
//

import Foundation

struct MoviesResponseModel: Decodable, Hashable {
    let page: Int
    let results: [Movie]
}
