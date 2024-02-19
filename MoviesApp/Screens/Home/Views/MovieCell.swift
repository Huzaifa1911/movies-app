//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.setIndicatorColor(color: .appTheme.secondaryText)
        imageView.backgroundColor = .appTheme.lightBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    func configure(poster: String) {
        posterImageView.setImage(urlString: poster, downsamplingSize: CGSize(width: 300, height: 300))
    }
}
