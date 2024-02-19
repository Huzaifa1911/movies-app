//
//  BlankStateViewCell.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

class BlankStateViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let blankStateView: BlankStateView = {
        let view = BlankStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews() {
        contentView.addSubview(blankStateView)
        
        NSLayoutConstraint.activate([
            blankStateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blankStateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blankStateView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blankStateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with blankState: BlankState) {
        blankStateView.titleLabel.text = blankState.title
        blankStateView.subTitleLabel.text = blankState.subTitle
        blankStateView.iconImageView.image = blankState.icon
    }
}
