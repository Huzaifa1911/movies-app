//
//  WatchlistViewController.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

protocol WatchlistViewControllerDelegate: AnyObject {
    func didTappedOnMovie(movieId: Int)
}

class WatchlistViewController: UIViewController {
    init(viewModel: WatchlistViewModel = .init()) {
        watchListViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: WatchlistViewControllerDelegate?
    let watchListViewModel: WatchlistViewModel
    
    private let watchlistMoviesTableView: WatchlistMoviesTableView = {
        let tableView = WatchlistMoviesTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .appTheme.text
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchlistMoviesTableView.moviesTableViewDelegate = self
        watchListViewModel.delegate = self
        watchListViewModel.fetchWatchlistMovies()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .appTheme.background
        title = "Watch list"
        view.addSubview(watchlistMoviesTableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            watchlistMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            watchlistMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            watchlistMoviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            watchlistMoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - WatchlistViewModel delegate configuration
extension WatchlistViewController: WatchlistViewModelDelegate {
    func didThrowError(error: String) {
        showErrorAlert(with: error)
    }
    
    func didLoadMoreMovies(movieResponse: MoviesResponse) {
        watchlistMoviesTableView.loadMoreMovies(movieResponse: movieResponse)
    }
    
    func didFetchedWatchlistMovies(movieResponse: MoviesResponse) {
        watchlistMoviesTableView.configureMovies(movieResponse: movieResponse)
    }
    
    func didIsLoadingTriggered(isLoading: Bool) {
        isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
    }
}

// MARK: - MoviesTableView delegate configuration
extension WatchlistViewController: MoviesTableViewDelegate {
    func didTappedOnMovie(movieId: Int) {
        delegate?.didTappedOnMovie(movieId: movieId)
    }
    
    func didReachedEnd(page: Int) {
        watchListViewModel.loadMoreMovies(page: page)
    }
}
