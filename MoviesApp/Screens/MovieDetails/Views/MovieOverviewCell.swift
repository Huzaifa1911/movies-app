//
//  MovieOverviewCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit
import Kingfisher

class MovieOverviewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.setIndicatorColor(color: .appTheme.secondaryText)
        imageView.backgroundColor = .appTheme.lightBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.setIndicatorColor(color: .appTheme.secondaryText)
        imageView.backgroundColor = .appTheme.lightBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.setFont(font: .semiBold, size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseYearView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.calendar)
        view.icon.tintColor = .appTheme.darkGray
        view.textLabel.textColor = .appTheme.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let popularityView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.star, verticalPadding: 4, horizontalPadding: 8)
        view.icon.tintColor = .appTheme.orange
        view.textLabel.setFont(font: .semiBold, size: 12, color: .appTheme.orange)
        view.backgroundColor = .appTheme.darkGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let playingTimeView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.clock)
        view.icon.tintColor = .appTheme.darkGray
        view.textLabel.textColor = .appTheme.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieGenreView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.ticket)
        view.icon.tintColor = .appTheme.darkGray
        view.textLabel.textColor = .appTheme.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieFeaturesStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 12
        return view
    }()
    
    private func createDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .appTheme.darkGray
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func setupViews() {
        contentView.addSubview(backdropImageView)
        contentView.addSubview(popularityView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieFeaturesStackView)
        movieFeaturesStackView.addArrangedSubview(releaseYearView)
        movieFeaturesStackView.addArrangedSubview(createDivider())
        movieFeaturesStackView.addArrangedSubview(playingTimeView)
        movieFeaturesStackView.addArrangedSubview(createDivider())
        movieFeaturesStackView.addArrangedSubview(movieGenreView)
        
        NSLayoutConstraint.activate([
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 210),
            
            popularityView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -11),
            popularityView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -8),
            
            posterImageView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 29),
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -60),
            posterImageView.heightAnchor.constraint(equalToConstant: 120),
            posterImageView.widthAnchor.constraint(equalToConstant: 95),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            movieTitleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 12),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            movieFeaturesStackView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 34),
            movieFeaturesStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 24),
            movieFeaturesStackView.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor),
            movieFeaturesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String, releaseDate: String, playingTime: Int, popularity: Double, genre: String, backgdropImage: String, posterImage: String) {
        movieTitleLabel.text = title
        releaseYearView.textLabel.text = releaseDate.formatDate(outputFormat: "yyyy")
        playingTimeView.textLabel.text = "\(playingTime) Minutes"
        popularityView.textLabel.text = "\(popularity)"
        movieGenreView.textLabel.text = genre
        backdropImageView.setImage(urlString: backgdropImage,
                                   downsamplingSize: CGSize(width: 700, height: 700),
                                   tintColor: .appTheme.darkGray
        )
        posterImageView.setImage(urlString: posterImage,
                                 downsamplingSize: CGSize(width: 500, height: 500),
                                 tintColor: .appTheme.darkGray
        )
    }
}
