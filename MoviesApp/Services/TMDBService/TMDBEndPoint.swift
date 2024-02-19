//
//  TMDBEndPoint.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

enum TMDBEndPoint: Endpoint {
    //MARK: queries
    case getTrendingMovies(timeWindow: String, page: Int)
    case getNowPlayingMovies(page: Int)
    case getUpcomingMovies(page: Int)
    case getTopRatedMovies(page: Int)
    case getPopularMovies(page: Int)
    case getWatchlistMovies(page:Int)
    
    case getMovieDetails(id: Int)
    case searchMovieByName(name: String, page: Int)
    case getMovieReviews(movieId: Int)
    case getMovieCast(movieId: Int)
    //MARK: mutations
    case addToMovieToWatchlist(movieId: Int)
    
    var host: String {
        TMDBConstants.host
    }
    
    var accessToken: String {
        TMDBConstants.accessTokenAuth
    }
    
    
    var path: String {
        switch self {
        case .getTrendingMovies(let timeWindow, _):
            return "/\(TMDBConstants.apiVersion)/trending/movie/\(timeWindow)"
        case .getNowPlayingMovies:
            return "/\(TMDBConstants.apiVersion)/movie/now_playing"
        case .getUpcomingMovies:
            return "/\(TMDBConstants.apiVersion)/movie/upcoming"
        case .getTopRatedMovies:
            return "/\(TMDBConstants.apiVersion)/movie/top_rated"
        case .getPopularMovies:
            return "/\(TMDBConstants.apiVersion)/movie/popular"
        case .getMovieDetails(let id):
            return "/\(TMDBConstants.apiVersion)/movie/\(id)"
        case .searchMovieByName:
            return "/\(TMDBConstants.apiVersion)/search/movie"
        case .getMovieReviews(let id):
            return "/\(TMDBConstants.apiVersion)/movie/\(id)/reviews"
        case .getMovieCast(let id):
            return "/\(TMDBConstants.apiVersion)/movie/\(id)/credits"
        case .getWatchlistMovies:
            return "/\(TMDBConstants.apiVersion)/account/\(TMDBConstants.accountId)/watchlist/movies"
        case .addToMovieToWatchlist:
            return "/\(TMDBConstants.apiVersion)/account/\(TMDBConstants.accountId)/watchlist"
        }
    }
    
    var httpMethod: RequestMethod {
        switch self {
        case .getTrendingMovies,
                .getNowPlayingMovies,
                .getUpcomingMovies,
                .getTopRatedMovies,
                .getMovieDetails,
                .searchMovieByName,
                .getWatchlistMovies,
                .getMovieReviews,
                .getMovieCast:
            return .get
        case .addToMovieToWatchlist:
            return .post
        default:
            return .get
        }
    }
    
    var params: [String: String] {
        var params: [String: String] = ["language": "en-US"]
        
        switch self {
        case .getNowPlayingMovies(let page),
                .getPopularMovies(let page),
                .getUpcomingMovies(let page),
                .getWatchlistMovies(let page),
                .getTopRatedMovies(let page),
                .getTrendingMovies(_, let page):
            params["page"] = String(page)
            return params
        case .searchMovieByName(let name, let page):
            params["query"] = name
            params["page"] = String(page)
            return params
        case .getMovieDetails:
            params["append_to_response"] = "account_states"
            return params
        default:
            return params
        }
    }
    
    var body: [String : Any] {
        var body: [String: Any] = [:]
        switch self {
        case .addToMovieToWatchlist(let id):
            body["media_id"] = id
            body["media_type"] = "movie"
            body["watchlist"] = true
            return body
        default:
            return body
        }
    }
}
