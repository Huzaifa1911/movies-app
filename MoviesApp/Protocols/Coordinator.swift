//
//  Coordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    //    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
}


extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func finish () {
        // Default implementation is that the coordinator removes itself from its parent's childCoordinators.
        //        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
