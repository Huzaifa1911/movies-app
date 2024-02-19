//
//  SearchCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class SearchCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.delegate = self
        let searchVC = SearchViewController()
        searchVC.delegate = self
        navigationController.viewControllers = [searchVC]
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let movieDetailsViewController = fromViewController as? MovieDetailsViewController {
            childDidFinish(movieDetailsViewController.coordinator)
        }
    }
}


// MARK: SearchViewControllerDelegate Configuration
extension SearchCoordinator: SearchViewControllerDelegate {
    func didTappedOnMovie(movieId: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movieId: movieId)
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
    }
}
