//
//  SearchBar.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 09/02/2024.
//

import UIKit

protocol SearchbarDelegate: AnyObject {
    func searchBar(textDidChange searchText: String?)
}

class SearchBar: UITextField {
    weak var searchBarDelegate: SearchbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSearchTextField()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return .init(x: bounds.width - 30, y: 0, width: 20 , height: bounds.height)
    }
    
    private let padding = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 17)
    
    private let rightIconButton: UIButton = {
        let button = UIButton()
        button.setImage(.icons.magnifyingGlass?.size(of: 16), for: .normal)
        button.tintColor = .appTheme.darkGray
        return button
    }()
    
    // MARK: Called when user starts typing
    @objc private func didEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        searchBarDelegate?.searchBar(textDidChange: text)
        
        if text.isEmpty.inverted {
            rightIconButton.setImage(.icons.xmark?.size(of: 16), for: .normal)
        } else {
            rightIconButton.setImage(.icons.magnifyingGlass?.size(of: 16), for: .normal)
        }
    }
    
    // MARK: Called when user tapped on right icon
    @objc private func didTappedOnRightIcon() {
        // MARK: Only set focus when searchbar not focused.
        if isFirstResponder.inverted {
            becomeFirstResponder()
        }
        // MARK: If textfield has text then, clear text, inform the delegate, and update the button icon
        guard let enteredText = text else { return }
        if enteredText.isEmpty.inverted {
            text = nil
            searchBarDelegate?.searchBar(textDidChange: nil)
            rightIconButton.setImage(.icons.magnifyingGlass?.size(of: 16), for: .normal)
        }
    }
    
    @objc private func didEnteredPressed() {
        resignFirstResponder()
    }
    
    private func setupSearchTextField() {
        frame.size.height = 42
        layer.cornerRadius = 16
        textAlignment = .left
        leftView = nil
        rightView = rightIconButton
        rightViewMode = .always
    }
    
    private func setup() {
        backgroundColor = .appTheme.lightBackground
        setFont(font: .regular, size: 14)
        placeholder = "Search"
        attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appTheme.darkGray]
        )
        
    }
    
    private func setupActions() {
        rightIconButton.addTarget(self, action: #selector(didTappedOnRightIcon), for: .touchUpInside)
        addTarget(self, action: #selector(didEditingChanged(_ :)), for: .editingChanged)
        addTarget(self, action: #selector(didEnteredPressed), for: .editingDidEndOnExit)
    }
}
