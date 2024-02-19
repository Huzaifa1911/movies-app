//
//  MovieTableView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 12/02/2024.
//

import UIKit

protocol MoviesTableViewDelegate: AnyObject {
    func didTappedOnMovie(movieId: Int)
    func didReachedEnd(page: Int)
}

class MoviesTableView: UITableView {
    var movieResponse: MoviesResponse
    var blankState: BlankState
    weak var moviesTableViewDelegate: MoviesTableViewDelegate?
    
    init(dataSource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil) {
        movieResponse = .init()
        blankState = BlankState()
        super.init(frame: .zero, style: .insetGrouped)
        self.dataSource = dataSource
        self.delegate = delegate
        backgroundColor = .appTheme.background
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        register(MovieTableViewCell.self, forCellReuseIdentifier: "\(MovieTableViewCell.self)")
    }
    
    func configureMovies(movieResponse: MoviesResponse) {
        self.movieResponse = movieResponse
        reloadData()
    }
    
    func loadMoreMovies(movieResponse: MoviesResponse) {
        self.movieResponse = .init(
            page: movieResponse.page,
            results: self.movieResponse.results + movieResponse.results,
            totalPages: movieResponse.totalPages,
            totalResults: movieResponse.totalResults
        )
        hidesLoadingIndicator()
        reloadData()
    }
}
