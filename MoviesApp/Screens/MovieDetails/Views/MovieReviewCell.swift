//
//  MovieReviewCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

class MovieReviewCell: UICollectionViewCell {
    private let avatarSize: CGFloat = 44
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.setIndicatorColor(color: .appTheme.secondaryText)
        imageView.backgroundColor = .appTheme.lightBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = avatarSize * 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .semiBold, size: 12)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let reviewContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .regular, size: 12)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let reviewRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .semiBold, size: 12, color: .appTheme.oceanBlue)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(reviewRatingLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(reviewContentLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarSize),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            reviewContentLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 4),
            reviewContentLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor),
            reviewContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            reviewRatingLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 14),
            reviewRatingLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            reviewRatingLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
        ])
    }
    
    func configure(authorName: String, reviewContent: String, avatar: String, rating: Int) {
        authorNameLabel.text = authorName
        reviewContentLabel.text = reviewContent
        reviewRatingLabel.text = "\(rating)"
        avatarImageView.setImage(
            urlString: avatar,
            placeholderImage: .icons.avatar,
            downsamplingSize: CGSize(width: 100, height: 100),
            tintColor: .appTheme.darkGray
        )
    }
}
