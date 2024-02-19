//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 12/02/2024.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let movieImageView: UIImageView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .regular, size: 16)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let releaseYearView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.calendar)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let popularityView: MovieFeatureView = {
        let view = MovieFeatureView(icon: .icons.star)
        view.icon.tintColor = .appTheme.orange
        view.textLabel.setFont(font: .semiBold, size: 12, color: .appTheme.orange)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 12, left: 0, bottom: 12, right: 0))
    }
    
    private func setupViews() {
        backgroundColor = .appTheme.background
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearView)
        contentView.addSubview(popularityView)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 95),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            popularityView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            popularityView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            popularityView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            releaseYearView.topAnchor.constraint(equalTo: popularityView.bottomAnchor, constant: 4),
            releaseYearView.leadingAnchor.constraint(equalTo: popularityView.leadingAnchor),
            releaseYearView.trailingAnchor.constraint(equalTo: popularityView.trailingAnchor),
            
        ])
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configure(title: String, image: String, releaseYear: String, popularity: Double) {
        titleLabel.text = title
        popularityView.textLabel.text = "\(popularity)"
        releaseYearView.textLabel.text = releaseYear.formatDate(outputFormat: "yyyy")
        movieImageView.setImage(urlString: image,
                                placeholderImage: .icons.photo,
                                downsamplingSize: CGSize(width: 500, height: 500),
                                tintColor: .appTheme.darkGray
        )
    }
}
