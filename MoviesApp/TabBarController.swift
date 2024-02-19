//
//  TabBarController.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

class TabBarController: UITabBarController {

    private var coordinators = [Coordinator]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabController()
        viewControllers = [.home, .search, .watchlist].map { getTabNavigationController(for: $0) }
    }
    
    private func getTabNavigationController(for tab: Tab) -> UINavigationController {
        let coordinator: Coordinator
        let navigationController = UINavigationController()
        
        switch tab {
        case .home:
            coordinator = HomeCoordinator(navigationController: navigationController)
        case .search:
            coordinator = SearchCoordinator(navigationController: navigationController)
        case .watchlist:
            coordinator = WatchlistCoordinator(navigationController: navigationController)
            
        }
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.setFont(font: .semiBold, size: 16, color: .appTheme.secondaryText)
        navigationController.tabBarItem = .init(
            title: tab.title,
            image: tab.tabIcon,
            tag: tab.tabIndex
        )
        navigationController.tabBarItem.setFont(
            font: .semiBold,
            size: 10,
            color: tab.color,
            selectedColor: tab.selectedColor
        )
        coordinator.start()
        coordinators.append(coordinator) // need to hold the references of coordinators
        return navigationController
    }
    
    // handles appearance of tabBar
    private func setupTabController() {
        tabBar.backgroundColor = .appTheme.background
        tabBar.barTintColor = .appTheme.background
        tabBar.tintColor = .appTheme.oceanBlue
        tabBar.unselectedItemTintColor = .appTheme.darkGray
        tabBar.isTranslucent = false
        tabBar.layer.addBorder(edge: .top, thickness: 1, color: .appTheme.oceanBlue)
    }
}
