//
//  WatchlistCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class WatchlistCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let watchlistViewModel: WatchlistViewModel
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.watchlistViewModel = .init()
    }
    
    @objc private func watchlistUpdated() {
        watchlistViewModel.fetchWatchlistMovies()
    }
    
    func start() {
        // Add Observer to listen for notification generated when movie added to watchlist
        NotificationCenter.default.addObserver(self, selector: #selector(watchlistUpdated), name: .watchlistUpdated, object: nil)
        self.navigationController.delegate = self
        let watchlistVC = WatchlistViewController(viewModel: watchlistViewModel)
        watchlistVC.delegate = self
        navigationController.viewControllers = [watchlistVC]
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let movieDetailsViewController = fromViewController as? MovieDetailsViewController {
            childDidFinish(movieDetailsViewController.coordinator)
        }
    }
}

// MARK: - WatchlistViewControllerDelegate Configuration
extension WatchlistCoordinator: WatchlistViewControllerDelegate {
    func didTappedOnMovie(movieId: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movieId: movieId)
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
    }
}
