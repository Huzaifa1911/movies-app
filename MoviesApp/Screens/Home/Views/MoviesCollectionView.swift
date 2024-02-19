//
//  MoviesCollectionView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit

protocol MoviesCollectionViewDelegate: AnyObject {
    func didSelectMoviesCollectionFilter(filter: MovieFilter)
    func didBeginSearching()
    func didTappedOnMovieCell(movieId: Int)
    func didMovieListSectionReachedEnd(page: Int)
}

class MoviesCollectionView: UICollectionView {
    weak var moviesCollectionViewDelegate: MoviesCollectionViewDelegate?
    
    private var movieFilters: [MovieFilter]
    private var trendingMovies: [Movie]
    private var movieResponse: MoviesResponse
    private var selectedMovieFilter: MovieFilter
    private var prevSelectedMovieFilter: MovieFilter
    private var isLoading: Bool
    
    init() {
        movieResponse = .init()
        trendingMovies = []
        movieFilters = []
        isLoading = false
        prevSelectedMovieFilter = .nowPlaying
        selectedMovieFilter = .nowPlaying
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setCollectionViewLayout(moviesCollectionViewLayout(), animated: true)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .appTheme.background
        registerCellsAndReuseableViews()
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCellsAndReuseableViews() {
        register(TrendingMovieCell.self, forCellWithReuseIdentifier: "\(TrendingMovieCell.self)")
        register(MovieCell.self, forCellWithReuseIdentifier: "\(MovieCell.self)")
        register(MovieFilterAttributeCell.self, forCellWithReuseIdentifier: "\(MovieFilterAttributeCell.self)")
        register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SearchHeaderView.self)")
        register(LoadingIndicatorCell.self, forCellWithReuseIdentifier: "\(LoadingIndicatorCell.self)")
    }
    
    private func moviesCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // MARK: - Trending Movies Section
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .estimated(230))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(90))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [sectionHeader]
                section.contentInsets = .init(top: 20, leading: 20 , bottom: 0, trailing: 20)
                return section
                
            }
            // MARK: - Movies Filters
            else if sectionIndex == 1 {
                let layoutSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
                
                let section = NSCollectionLayoutSection(
                    group: .horizontal(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                )
                section.interGroupSpacing = 18
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 45, leading: 20, bottom: 0, trailing: 20)
                return section
                
            }
            // MARK: - Movies List
            else if sectionIndex == 2 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .flexible(13)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 18
                section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
                return section
            }
            else if sectionIndex == 3 {
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
                return section
            }
            return nil
        }
    }
    
    func configureMovieResponseAgainstFocusedFilter(_ movieResponse: MoviesResponse) {
        if selectedMovieFilter == prevSelectedMovieFilter { // Means filter is not updated, and api call is made based on scrolling
            self.movieResponse = .init(
                page: movieResponse.page,
                results: self.movieResponse.results + movieResponse.results,
                totalPages: movieResponse.totalPages,
                totalResults: movieResponse.totalResults
            )
            
        } else {
            self.movieResponse = movieResponse
        }
        isLoading = false
        reloadData()
    }
    
    func configureTrendingMovies(_ trendingMovies: [Movie]) {
        self.trendingMovies = trendingMovies
        reloadSections(.init(integer: 0))
    }
    
    func configureCollectionFilters(_ collectionFilters: [MovieFilter]) {
        self.movieFilters = collectionFilters
    }
}

// MARK: MoviesCollectionView DataSource configuration
extension MoviesCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return trendingMovies.count
        case 1:
            return movieFilters.count
        case 2:
            return movieResponse.results.count
        case 3:
            return isLoading ? 1 : 0
        default:
            assert(false, "Invalid Element Type")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TrendingMovieCell.self)", for: indexPath) as! TrendingMovieCell
            let movie = trendingMovies[indexPath.item]
            cell.configure(poster: movie.posterUrl, rating: indexPath.item + 1)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieFilterAttributeCell.self)", for: indexPath) as! MovieFilterAttributeCell
            let filter = movieFilters[indexPath.item]
            cell.configure(title: filter.rawValue, isSelected: filter == selectedMovieFilter)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
            let movie = movieResponse.results[indexPath.item]
            cell.configure(poster: movie.posterUrl)
            return cell
        case  3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LoadingIndicatorCell.self)", for: indexPath) as! LoadingIndicatorCell
            cell.configure(isLoading: isLoading)
            return cell
        default:
            assert(false, "Invalid Element Type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let headerView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SearchHeaderView.self)", for: indexPath) as! SearchHeaderView
            headerView.delegate = self // setting the searchHeaderViewDelegate to collectionView instance
            return headerView
        default:
            assert(false, "Invalid Element Type")
        }
    }
}

// MARK: MoviesCollectionViewDelegate configuration
extension MoviesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            moviesCollectionViewDelegate?.didTappedOnMovieCell(movieId: trendingMovies[indexPath.item].id)
        case 1:
            let filter = movieFilters[indexPath.item]
            prevSelectedMovieFilter = selectedMovieFilter
            selectedMovieFilter = filter
            moviesCollectionViewDelegate?.didSelectMoviesCollectionFilter(filter: filter)
        case 2:
            moviesCollectionViewDelegate?.didTappedOnMovieCell(movieId: movieResponse.results[indexPath.item].id)
        default:
            assert(false, "Invalid Element Type")
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((contentOffset.y + frame.size.height) >= contentSize.height - 100) && (movieResponse.page < movieResponse.totalPages) && !isLoading {
            /* if scrolling through same filter, update the prevSelectedFilter to be same as current selectedFilter.
             This will keep the previous records and updates the list */
            prevSelectedMovieFilter = selectedMovieFilter
            isLoading = true
            reloadSections(.init(integer: 3)) // reloading the loading section
            moviesCollectionViewDelegate?.didMovieListSectionReachedEnd(page: movieResponse.page + 1)
        }
    }
}

// MARK: SearchHeaderViewDelegate
extension MoviesCollectionView: SearchHeaderViewDelegate {
    func didBeginSearching() {
        moviesCollectionViewDelegate?.didBeginSearching()
    }
}
