//
//  MovieDetailsCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let movieId: Int
    
    init (navigationController: UINavigationController, movieId: Int) {
        self.movieId = movieId
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MovieDetailsViewController(movieId: movieId)
        vc.coordinator = self
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}


extension MovieDetailsCoordinator: MovieDetailsViewControllerDelegate {
    func didMovieAddedToWatchList() {
        NotificationCenter.default.post(name: .watchlistUpdated, object: nil)
    }
}
