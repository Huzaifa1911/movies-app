//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func didTappedOnMovie(movieId: Int)
}

class SearchViewController: UIViewController {
    weak var delegate: SearchViewControllerDelegate?
    var searchViewModel: SearchViewModel
    
    private let searchedMoviesTableView: SearchedMoviesTableView = { // lazy initialize to have self
        let tableView = SearchedMoviesTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .appTheme.text
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: SearchViewModel = .init()) {
        searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        searchedMoviesTableView.moviesTableViewDelegate = self
        searchedMoviesTableView.searchedMoviesTableViewDelegate = self
        view.backgroundColor = .appTheme.background
        title = "Search"
        searchViewModel.fetchMovies() // do the initial fetch
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(searchedMoviesTableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            searchedMoviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchedMoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchedMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchedMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: SearchViewModel Configuration
extension SearchViewController: SearchViewModelDelegate {
    func didThrowError(error: String) {
        showErrorAlert(with: error)
    }
    
    func didLoadMoreMovies(movieResponse: MoviesResponse) {
        searchedMoviesTableView.loadMoreMovies(movieResponse: movieResponse)
    }
    
    func didFetchMovies(movieResponse: MoviesResponse) {
        searchedMoviesTableView.configureMovies(movieResponse: movieResponse)
    }
    
    func didIsLoadingTriggered(isLoading: Bool) {
        isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
    }
}

// MARK: SearchtableViewDelegate configuration
extension SearchViewController: SearchedMoviesTableViewDelegate {
    func didTappedOnMovie(movieId: Int) {
        delegate?.didTappedOnMovie(movieId: movieId)
    }
}

// MARK: MoviesTableViewDelegate configuration
extension SearchViewController: MoviesTableViewDelegate {
    func didSearchTextChanged(text: String?) {
        searchViewModel.fetchMovies(for: text)
    }
    
    func didReachedEnd(page: Int) {
        searchViewModel.loadMoreMovies(page: page)
    }
}
