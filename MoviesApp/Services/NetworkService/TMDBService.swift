//
//  TMDBService.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

enum TMDBEndPoint: Endpoint {
    case getTrendingMovies(timeWindow: String)
    case getNowPlayingMovies
    case getUpcomingMovies
    case getTopRatedMovies
    case getPopularMovies
    case getMovieDetails(id: Int)
    case searchMovieByName(name: String)
    
    var path: String {
        switch self {
        case .getTrendingMovies(let timeWindow):
            return "movie/\(timeWindow)"
        case .getNowPlayingMovies:
            return "movie/now_playing"
        case .getUpcomingMovies:
            return "movie/upcoming"
        case .getTopRatedMovies:
            return "movie/top_rated"
        case .getPopularMovies:
            return "movie/popular"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        case .searchMovieByName:
            return "search/movie"
        }
    }
    
    var httpMethod: RequestMethod {
        switch self {
        case .getTrendingMovies, .getNowPlayingMovies, .getUpcomingMovies, .getTopRatedMovies, .getMovieDetails, .searchMovieByName:
            return .get
        default:
            return .get
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .searchMovieByName(let name):
            return ["query": name]
        default:
            return [:]
        }
    }
}
