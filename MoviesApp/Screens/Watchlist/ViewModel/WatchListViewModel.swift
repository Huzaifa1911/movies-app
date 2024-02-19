//
//  WatchListViewModel.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 15/02/2024.
//

import Foundation

protocol WatchlistViewModelDelegate: AnyObject {
    func didFetchedWatchlistMovies(movieResponse: MoviesResponse)
    func didLoadMoreMovies(movieResponse: MoviesResponse)
    func didIsLoadingTriggered(isLoading: Bool)
    func didThrowError(error: String)
}

class WatchlistViewModel {
    weak var delegate: WatchlistViewModelDelegate?
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
    
    func fetchWatchlistMovies() {
        Task { @MainActor in
            do {
                isLoading = true
                let movieResponse: MoviesResponse = try await tmdbServiceManager.getMoviesList(type: .getWatchlistMovies(page: 1))
                delegate?.didFetchedWatchlistMovies(movieResponse: movieResponse)
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    func loadMoreMovies(page: Int = 1) {
        Task { @MainActor in
            do {
                let movieResponse: MoviesResponse = try await tmdbServiceManager.getMoviesList(type: .getWatchlistMovies(page: page))
                delegate?.didLoadMoreMovies(movieResponse: movieResponse)
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
            }
        }
    }
    
}
