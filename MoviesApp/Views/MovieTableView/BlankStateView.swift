//
//  BlankStateView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import UIKit

class BlankStateView: UIView {
    init(state: BlankState) {
        super.init(frame: .zero)
        titleLabel.text = state.title
        subTitleLabel.text = state.subTitle
        iconImageView.image = state.icon
        setupViews()
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .semiBold, size: 16)
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setFont(font: .regular, size: 12)
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 75),
            iconImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 75),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
