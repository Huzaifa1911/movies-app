//
//  HomeCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        self.navigationController.delegate = self
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.viewControllers = [homeVC]
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let movieDetailsViewController = fromViewController as? MovieDetailsViewController {
            childDidFinish(movieDetailsViewController.coordinator)
        }
    }
}


extension HomeCoordinator: HomeViewControllerDelegate {
    func didTapOnSearchbar() {
        navigationController.tabBarController?.selectedIndex = Tab.search.tabIndex
    }
    
    func didTappedOnMovie(movieId: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movieId: movieId)
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
    }
}
