//
//  SearchCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.setFont(font: .semiBold, size: 16, color: .appTheme.secondaryText)
        rootViewController.tabBarItem = .init(title: "Search", image: .icons.magnifyingGlass?.setSize(of: 14), tag: 0)
        rootViewController.tabBarItem.setFont(font: .semiBold, size: 10, color: .appTheme.text, selectedColor: .appTheme.oceanBlue)
    }
    
    func start() {
        let searchVC = SearchViewController()
        rootViewController.setViewControllers([searchVC], animated: false)
    }
}
