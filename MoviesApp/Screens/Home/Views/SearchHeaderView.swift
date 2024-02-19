//
//  SearchHeaderView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit

protocol SearchHeaderViewDelegate: AnyObject {
    func didBeginSearching()
}

class SearchHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: SearchHeaderViewDelegate?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.setFont(font: .semiBold, size: 18, color: .appTheme.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.isUserInteractionEnabled = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    private func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchHeaderView))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
//        searchBar.delegate = self
        addSubview(headerLabel)
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 24),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension SearchHeaderView {
    @objc private func didTapSearchHeaderView() {
        delegate?.didBeginSearching()
    }
}

//extension SearchHeaderView: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        delegate?.didBeginSearching()
//    }
//}
