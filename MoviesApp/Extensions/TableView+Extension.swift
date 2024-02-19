//
//  TableView+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

extension UITableView {
    func showBlankStateView(with state: BlankState) {
        let blankStateView = BlankStateView(state: state)
        self.backgroundView = blankStateView
        self.separatorStyle = .none
    }
    
    func hidesBlankStateView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.color = .appTheme.text
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
        
        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
    
    func hidesLoadingIndicator() {
        self.tableFooterView?.isHidden = true
        self.tableFooterView = nil
    }
}
