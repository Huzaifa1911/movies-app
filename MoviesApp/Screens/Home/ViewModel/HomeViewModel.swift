//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 06/02/2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchMovies(movieResponse: MoviesResponse)
    func didFetchTrendingMovies(movies: [Movie])
    func didIsLoadingTriggered(isLoading: Bool)
    func didThrowError(error: String)
}


class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private let tmdbServiceManager: TMDBServiceManager
    let moviesCollectionFilters: [MovieFilter] = MovieFilter.allCases
    var focusedFilter: MovieFilter // MARK: used to load more data for currently selected filter
    
    private var isLoading: Bool {
        didSet {
            delegate?.didIsLoadingTriggered(isLoading: isLoading)
        }
    }
    
    init() {
        isLoading = false
        focusedFilter = .nowPlaying // initially focused filter is now playing
        tmdbServiceManager = TMDBServiceManager()
    }
    
    private func getEndpointForCurrentlyFocusedFilter(page: Int) -> TMDBEndPoint {
        switch focusedFilter {
        case .nowPlaying:
            return .getNowPlayingMovies(page: page)
        case .popular:
            return .getPopularMovies(page: page)
        case .topRated:
            return .getTopRatedMovies(page: page)
        case .upcoming:
            return .getUpcomingMovies(page: page)
        }
    }
    
    // MARK: This function will be called when movie filter changed (Now Playing, Upcoming, Top Rated, Popular)
    func fetchMoviesList(filter: MovieFilter = .nowPlaying) {
        focusedFilter = filter
        
        Task { @MainActor in
            do {
                isLoading = true
                let movieResponse = try await tmdbServiceManager.getMoviesList(type: getEndpointForCurrentlyFocusedFilter(page: 1))
                delegate?.didFetchMovies(movieResponse: movieResponse)
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
                let movieResponse = try await tmdbServiceManager.getMoviesList(type: getEndpointForCurrentlyFocusedFilter(page: page))
                delegate?.didFetchMovies(movieResponse: movieResponse)
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
            }
        }
    }
    
    func fetchTrendingMovies(timeWindow: String) {
        Task { @MainActor in
            do {
                isLoading = true
                // MARK: Only select the top 10 movies based on popularity
                let trendingMovies = try await tmdbServiceManager.getTrendingMovies(timeWindow: timeWindow, page: 1).results
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(10)
                delegate?.didFetchTrendingMovies(movies: Array(trendingMovies))
                isLoading = false
            } catch {
                delegate?.didThrowError(error: error.localizedDescription)
                isLoading = false
            }
        }
    }
}
