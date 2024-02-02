//
//  ApplicationCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    let rootViewController: UITabBarController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UITabBarController()
        rootViewController.tabBar.backgroundColor = .appTheme.background
        rootViewController.tabBar.tintColor = .appTheme.oceanBlue
        rootViewController.tabBar.unselectedItemTintColor = .appTheme.darkGray
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.itemWidth = 20
        rootViewController.tabBar.layer.addBorder(edge: .top, thickness: 1, color: .appTheme.oceanBlue)
    }
    
    func start() {
        // home Coordinator
        let homeCoordinator = HomeCoordinator()
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        // search coordinator
        let searchCoordinator = SearchCoordinator()
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()
        
        // watch list coordinator
        let watchlistCoordinator = WatchlistCoordinator()
        childCoordinators.append(watchlistCoordinator)
        watchlistCoordinator.start()
        
        rootViewController.viewControllers = [homeCoordinator.rootViewController, searchCoordinator.rootViewController, watchlistCoordinator.rootViewController]
        window.rootViewController = rootViewController
    }
}
