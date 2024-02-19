//
//  MovieFeatureView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

class MovieFeatureView: UIView {
    private let iconSize: CGFloat
    private let verticalPadding: CGFloat
    private let horizontalPadding: CGFloat
    
    init(label: String? = nil, icon: UIImage? = nil, iconSize: CGFloat = 16, verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0) {
        self.iconSize = iconSize
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        super.init(frame: .zero)
        textLabel.text = label
        self.icon.image = icon
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.setFont(font: .regular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .appTheme.text
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupViews() {
        addSubview(icon)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding),
            icon.heightAnchor.constraint(equalToConstant: iconSize),
            icon.widthAnchor.constraint(equalToConstant: iconSize),
            
            
            textLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding)
        ])
    }
}
