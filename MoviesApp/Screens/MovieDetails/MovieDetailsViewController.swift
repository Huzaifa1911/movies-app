//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

protocol MovieDetailsViewControllerDelegate: AnyObject {
    func didMovieAddedToWatchList()
}

class MovieDetailsViewController: UIViewController {
    weak var coordinator: MovieDetailsCoordinator?
    weak var delegate: MovieDetailsViewControllerDelegate?
    private var movieDetailsViewModel: MovieDetailsViewModel
    private let movieId: Int
    private var hasMovieInUserWatchList: Bool // to let know the view that movie added to watch list
    
    private let movieDetailsCollectionView: MovieDetailsCollectionView = {
        let collectionView = MovieDetailsCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .appTheme.text
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: MovieDetailsViewModel = .init(), movieId: Int) {
        hasMovieInUserWatchList = false
        self.movieId = movieId
        movieDetailsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let isBarHidden =  navigationController?.navigationBar.isHidden else { return }
        if isBarHidden { // if transitioning from HomeViewController, show navigationBar
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.delegate = self
        movieDetailsCollectionView.movieDetailsCollectionViewDelegate = self
        movieDetailsCollectionView.configureMovieDetailsAttributes(movieDetailsViewModel.movieDetailsAttributes)
        movieDetailsViewModel.fetchMovieDetails(movieId: movieId)
        
        setupSubViews()
        prepareNavigationBarButton()
    }
    
    private func setupSubViews() {
        view.backgroundColor = .appTheme.background
        title = "Detail"
        navigationController?.navigationBar.barStyle = .black
        view.addSubview(movieDetailsCollectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            movieDetailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Setting the navigation bar buttons
    private func prepareNavigationBarButton() {
        navigationController?.navigationBar.tintColor = .appTheme.text
        // MARK: Right Button for bookmark
        navigationItem.rightBarButtonItem = .init(
            image: hasMovieInUserWatchList ? .icons.bookmarkFill : .icons.bookmark,
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )
        // MARK: Left button for back action
        navigationItem.leftBarButtonItem = .init(
            image: .icons.chevronLeft,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftButton)
        )
    }
    
    @objc private func didTappedLeftButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTappedRightBarButton() {
        if hasMovieInUserWatchList.inverted { // MARK: If Movie already in watchlist, do not add it again
            movieDetailsViewModel.addMovieToWatchlist(movieId: movieId)
        }
    }
}

// MARK: - MovieDetailsViewModel Delegate Configuration
extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func didThrowError(error: String) {
        showErrorAlert(with: error)
    }
    
    func didAddedMovieToWatchlist(success: Bool) {
        showToastMessage(with: success ? "Movie Added to watch list" : "Unable to add movie to watch list")
        hasMovieInUserWatchList = success
        navigationItem.rightBarButtonItem?.image = success ? .icons.bookmarkFill : .icons.bookmark
        delegate?.didMovieAddedToWatchList() // triggering an event call to let know that movie is added to watchlist
    }
    
    func didFetchMovieReviews(reviews: [MovieReview]) {
        movieDetailsCollectionView.configureReviews(reviews)
    }
    
    func didFetchMovieCast(cast: [MovieCast]) {
        movieDetailsCollectionView.configureCast(cast)
    }
    
    func didFetchMovieDetails(movieDetails: MovieDetail) {
        movieDetailsCollectionView.configureMovieDetails(movieDetails)
        if let hasMovieInWatchList = movieDetails.accountState?.watchlist {
            hasMovieInUserWatchList = hasMovieInWatchList
            navigationItem.rightBarButtonItem?.image = hasMovieInWatchList ? .icons.bookmarkFill : .icons.bookmark
        }
    }
    
    func didIsLoadingTriggered(isLoading: Bool) {
        isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
    }
}

// MARK: - MovieDetailsCollectionViewDelegate configuration
extension MovieDetailsViewController: MovieDetailsCollectionViewDelegate {
    func didSelectedMovieReviews() {
        movieDetailsViewModel.fetchMovieReviews(movieId: movieId)
    }
    
    func didSelectedMovieCast() {
        movieDetailsViewModel.fetchMovieCast(movieId: movieId)
    }
}
