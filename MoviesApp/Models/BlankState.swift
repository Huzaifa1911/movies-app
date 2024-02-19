//
//  BlankState.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

struct BlankState {
    let title: String
    let subTitle: String
    let icon: UIImage?
    
    init(title: String, subTitle: String, icon: UIImage?) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
    }
    
    init() {
        title = ""
        self.subTitle = ""
        self.icon = nil
    }
}
