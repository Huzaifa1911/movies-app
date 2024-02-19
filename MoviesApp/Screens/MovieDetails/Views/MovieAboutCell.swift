//
//  MovieAboutCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

class MovieAboutCell: UICollectionViewCell {
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.setFont(font: .regular, size: 12)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(movieOverviewLabel)
        
        NSLayoutConstraint.activate([
            movieOverviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieOverviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    func configure(about: String) {
        movieOverviewLabel.text = about
    }
}
