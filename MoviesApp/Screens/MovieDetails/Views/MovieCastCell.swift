//
//  MovieCastCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    private let profileImageSize: CGFloat = 120
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.setIndicatorColor(color: .appTheme.secondaryText)
        imageView.backgroundColor = .appTheme.lightBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageSize * 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let castNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .semiBold, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(castNameLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageSize),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            castNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            castNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            castNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(profile: String, name: String) {
        castNameLabel.text = name
        profileImageView.setImage(
            urlString: profile,
            placeholderImage: .icons.avatar,
            downsamplingSize: CGSize(width: 250, height: 250),
            tintColor: .appTheme.darkGray
        )
    }
}
