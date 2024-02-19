//
//  TMDBServiceManager.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

class TMDBServiceManager: NetworkServiceManager {
    func getTrendingMovies(timeWindow: String, page: Int) async throws -> MoviesResponse {
        let response: MoviesResponse = try await request(TMDBEndPoint.getTrendingMovies(timeWindow: timeWindow, page: page))
        return response
    }
    
    func getMoviesList (type: TMDBEndPoint) async throws -> MoviesResponse {
        switch type {
        case .getPopularMovies(let page):
            return try await request(TMDBEndPoint.getPopularMovies(page: page))
        case .getUpcomingMovies(let page):
            return try await request(TMDBEndPoint.getUpcomingMovies(page: page))
        case .getTopRatedMovies(let page):
            return try await request(TMDBEndPoint.getTopRatedMovies(page: page))
        case .getNowPlayingMovies(let page):
            return try await request(TMDBEndPoint.getNowPlayingMovies(page: page))
        case .getWatchlistMovies(let page):
            return try await request(TMDBEndPoint.getWatchlistMovies(page: page))
        default:
            return .init()
        }
    }
    
    func getMovieDetails(movieId: Int)  async throws -> MovieDetail {
        let movie: MovieDetail = try await request(TMDBEndPoint.getMovieDetails(id: movieId))
        return movie
    }
    
    func searchMovieByName(query: String, page: Int) async throws -> MoviesResponse {
        let response: MoviesResponse = try await request(TMDBEndPoint.searchMovieByName(name: query, page: page))
        return response
    }
    
    func getMoveCast(movieId: Int) async throws -> [MovieCast] {
        let response: MovieCastResponse = try await request(TMDBEndPoint.getMovieCast(movieId: movieId))
        return response.cast
    }
    
    func getMoveReviews(movieId: Int) async throws -> [MovieReview] {
        let response: MovieReviewsResponse = try await request(TMDBEndPoint.getMovieReviews(movieId: movieId))
        return response.results
    }
    
    func addToMovieToWatchlist(movieId: Int) async throws -> PostSuccessResponse {
        let response : PostSuccessResponse = try await request(TMDBEndPoint.addToMovieToWatchlist(movieId: movieId))
        return response
    }
}
