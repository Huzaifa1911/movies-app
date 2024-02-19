//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 12/02/2024.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFetchMovies(movieResponse: MoviesResponse)
    func didLoadMoreMovies(movieResponse: MoviesResponse)
    func didIsLoadingTriggered(isLoading: Bool)
    func didThrowError(error: String)
}

class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    private let tmdbServiceManager: TMDBServiceManager
    private var searchQuery: String? = nil
    private var isLoading: Bool {
        didSet {
            delegate?.didIsLoadingTriggered(isLoading: isLoading)
        }
    }
    
    init() {
        isLoading = false
        tmdbServiceManager = TMDBServiceManager()
    }
    
    
    func fetchMovies(for query: String? = nil) {
        searchQuery = query // saving this query, so that if loadMoreMovie Call made, it uses same search query
        
        Task { @MainActor in
            do {
                isLoading = true
                let movieResponse: MoviesResponse
                if query.isNotEmpty { // show trending movies initially
                    movieResponse = try await tmdbServiceManager.searchMovieByName(query: query!, page: 1)
                } else {
                    movieResponse = try await tmdbServiceManager.getTrendingMovies(timeWindow: "day", page: 1)
                }
                delegate?.didFetchMovies(movieResponse: movieResponse)
                isLoading = false
            } catch {
                isLoading = false
                delegate?.didThrowError(error: error.localizedDescription)
            }
        }
    }
    
    func loadMoreMovies(page: Int) {
        Task { @MainActor in
            do {
                let movieResponse: MoviesResponse
                if searchQuery.isNotEmpty { // show trending movies initially
                    movieResponse = try await tmdbServiceManager.searchMovieByName(query: searchQuery!, page: page)
                } else {
                    movieResponse = try await tmdbServiceManager.getTrendingMovies(timeWindow: "day", page: page)
                }
                delegate?.didLoadMoreMovies(movieResponse: movieResponse)
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
            }
        }
    }
}
