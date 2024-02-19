//
//  ViewController+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 15/02/2024.
//

import UIKit

extension UIViewController {
    func showToastMessage(with message: String, for duration: Double = 2.0) {
        showToast(on: self, with: message, for: duration)
    }
    
    func showErrorAlert(with error: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.view.backgroundColor = .appTheme.secondaryText
        alert.view.tintColor = .appTheme.background
        alert.view.layer.cornerRadius = 16
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: completion)
        }))
        self.parent?.present(alert, animated: true)
    }
}
