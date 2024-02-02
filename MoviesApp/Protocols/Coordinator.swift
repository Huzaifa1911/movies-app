//
//  Coordinator.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import Foundation

protocol Coordinator {
    func start()
    var childCoordinators: [Coordinator] { get set }
}
