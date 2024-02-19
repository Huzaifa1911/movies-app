//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapOnSearchbar()
    func didTappedOnMovie(movieId: Int)
}

class HomeViewController: UIViewController {
    private var homeViewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?
    
    private let moviesCollectionView: MoviesCollectionView = {
        let view = MoviesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .appTheme.text
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: HomeViewModel = .init()) {
        homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let isBarHidden = navigationController?.navigationBar.isHidden else { return }
        if isBarHidden.inverted {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        moviesCollectionView.moviesCollectionViewDelegate = self
        
        // do the initial fetch
        moviesCollectionView.configureCollectionFilters(homeViewModel.moviesCollectionFilters)
        homeViewModel.fetchTrendingMovies(timeWindow: "day")
        homeViewModel.fetchMoviesList()
        setupSubViews()
    }
    
    private func setupSubViews() {
        view.backgroundColor = .appTheme.background
        view.addSubview(moviesCollectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: HomeViewModelDelegate Configuration
extension HomeViewController: HomeViewModelDelegate {
    func didThrowError(error: String) {
        showErrorAlert(with: error)
    }
    
    func didIsLoadingTriggered(isLoading: Bool) {
        isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
    }
    
    func didFetchTrendingMovies(movies: [Movie]) {
        moviesCollectionView.configureTrendingMovies(movies)
    }
    
    func didFetchMovies(movieResponse: MoviesResponse) {
        moviesCollectionView.configureMovieResponseAgainstFocusedFilter(movieResponse)
    }
}

// MARK: MoviesCollectionViewDelegate configuration
extension HomeViewController: MoviesCollectionViewDelegate {
    func didTappedOnMovieCell(movieId: Int) {
        delegate?.didTappedOnMovie(movieId: movieId)
    }
    
    func didSelectMoviesCollectionFilter(filter: MovieFilter) {
        homeViewModel.fetchMoviesList(filter: filter)
    }
    
    func didBeginSearching() {
        delegate?.didTapOnSearchbar()
    }
    
    func didMovieListSectionReachedEnd(page: Int) {
        homeViewModel.loadMoreMovies(page: page)
    }
}
