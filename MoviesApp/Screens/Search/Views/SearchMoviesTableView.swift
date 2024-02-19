//
//  SearchedMoviesTableView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 12/02/2024.
//

import UIKit

protocol SearchedMoviesTableViewDelegate: AnyObject {
    func didSearchTextChanged(text: String?)
}

class SearchedMoviesTableView: MoviesTableView {
    weak var searchedMoviesTableViewDelegate: SearchedMoviesTableViewDelegate?
    init() {
        super.init()
        setupViews()
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        blankState = .init(
            title: "we are sorry, we can not find the movie :(",
            subTitle: "Find your movie by Type title, categories, years, etc ",
            icon: .icons.noResult
        )
    }
}


//MARK: MoviesTableViewDataSource Configuration
extension SearchedMoviesTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieResponse.results.count == 0 ? showBlankStateView(with: blankState): hidesBlankStateView()
        return movieResponse.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath) as! MovieTableViewCell
        let movie = movieResponse.results[indexPath.item]
        cell.selectionStyle = .none
        cell.configure(
            title: movie.title,
            image: movie.posterUrl,
            releaseYear: movie.releaseDate,
            popularity: movie.popularity
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

// MARK: - MoviesTableViewDelegate configuration
extension SearchedMoviesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = SearchBar()
        searchBar.searchBarDelegate = self
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableViewDelegate?.didTappedOnMovie(movieId: movieResponse.results[indexPath.item].id)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((contentOffset.y + frame.size.height) >= contentSize.height) && movieResponse.page < movieResponse.totalPages {
            showLoadingIndicator()
            moviesTableViewDelegate?.didReachedEnd(page: movieResponse.page + 1)
        }
    }
}

//MARK: - Searchbar delegate configuration
extension SearchedMoviesTableView: SearchbarDelegate {
    func searchBar(textDidChange searchText: String?) {
        searchedMoviesTableViewDelegate?.didSearchTextChanged(text: searchText)
    }
}
