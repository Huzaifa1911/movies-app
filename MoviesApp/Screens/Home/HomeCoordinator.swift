//
//  HomeCoordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
        rootViewController.tabBarItem = .init(title: "Home", image: .icons.house?.setSize(of: 14), tag: 0)
        rootViewController.tabBarItem.setFont(font: .semiBold, size: 10, color: .appTheme.text, selectedColor: .appTheme.oceanBlue)
    }
    
    func start() {
        let homeVC = HomeViewController()
        rootViewController.setViewControllers([homeVC], animated: false)
    }
}
