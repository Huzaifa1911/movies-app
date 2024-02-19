//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import Foundation

protocol MovieDetailsViewModelDelegate: AnyObject {
    func didFetchMovieDetails(movieDetails: MovieDetail)
    func didFetchMovieReviews(reviews: [MovieReview])
    func didFetchMovieCast(cast: [MovieCast])
    func didIsLoadingTriggered(isLoading: Bool)
    func didAddedMovieToWatchlist(success: Bool)
    func didThrowError(error: String)
}

class MovieDetailsViewModel {
    weak var delegate: MovieDetailsViewModelDelegate?
    let movieDetailsAttributes: [MovieDetailsAttribute] = MovieDetailsAttribute.allCases
    private let tmdbServiceManager: TMDBServiceManager
    private var isLoading: Bool {
        didSet {
            delegate?.didIsLoadingTriggered(isLoading: isLoading)
        }
    }
    
    init() {
        isLoading = false
        tmdbServiceManager = TMDBServiceManager()
    }
    
    // MARK: - Get List of Movie Details
    func fetchMovieDetails(movieId: Int) {
        Task { @MainActor in
            do {
                isLoading = true
                let movieDetails: MovieDetail = try await tmdbServiceManager.getMovieDetails(movieId: movieId)
                delegate?.didFetchMovieDetails(movieDetails: movieDetails)
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    // MARK: - Get List of Movie Reviews
    func fetchMovieReviews(movieId: Int) {
        Task { @MainActor in
            do {
                isLoading = true
                let reviews: [MovieReview] = try await tmdbServiceManager.getMoveReviews(movieId: movieId)
                delegate?.didFetchMovieReviews(reviews: reviews)
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    // MARK: - Get List of Movie Cast
    func fetchMovieCast(movieId: Int) {
        Task { @MainActor in
            do {
                isLoading = true
                let cast: [MovieCast] = try await tmdbServiceManager.getMoveCast(movieId: movieId)
                delegate?.didFetchMovieCast(cast: cast)
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    // MARK: - Add Movie in watchlist
    func addMovieToWatchlist(movieId: Int) {
        Task { @MainActor in
            do {
                isLoading = true
                let response: PostSuccessResponse = try await tmdbServiceManager.addToMovieToWatchlist(movieId: movieId)
                delegate?.didAddedMovieToWatchlist(success: response.success)
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
}
