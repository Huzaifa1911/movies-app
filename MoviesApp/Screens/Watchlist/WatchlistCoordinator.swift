//
//  WatchlistCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class WatchlistCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.setFont(font: .semiBold, size: 16, color: .appTheme.secondaryText)
        rootViewController.tabBarItem = .init(title: "Watch list", image: .icons.bookmark?.setSize(of: 14), tag: 2)
        rootViewController.tabBarItem.setFont(font: .semiBold, size: 10, color: .appTheme.text, selectedColor: .appTheme.oceanBlue)
    }
    
    func start() {
        let watchlistVC = WatchlistViewController()
        rootViewController.setViewControllers([watchlistVC], animated: false)
    }
}
