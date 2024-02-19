//
//  MovieFilterAttributeCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit

class MovieFilterAttributeCell: UICollectionViewCell {
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.setFont(font: .semiBold, size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appTheme.lightBackground
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(filterLabel)
        contentView.addSubview(selectionIndicatorView)
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            selectionIndicatorView.heightAnchor.constraint(greaterThanOrEqualToConstant: 4),
            selectionIndicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectionIndicatorView.leadingAnchor.constraint(equalTo: filterLabel.leadingAnchor),
            selectionIndicatorView.trailingAnchor.constraint(equalTo: filterLabel.trailingAnchor),
        ])
    }
    
    func configure(title: String, isSelected: Bool) {
        filterLabel.text = title
        selectionIndicatorView.isHidden = isSelected.inverted
    }
}
