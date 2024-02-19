//
//  MovieDetailsCollectionView.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 14/02/2024.
//

import UIKit

protocol MovieDetailsCollectionViewDelegate: AnyObject {
    func didSelectedMovieReviews()
    func didSelectedMovieCast()
}

class MovieDetailsCollectionView: UICollectionView {
    weak var movieDetailsCollectionViewDelegate: MovieDetailsCollectionViewDelegate?
    private var selectedMovieAttribute: MovieDetailsAttribute {
        didSet {
            reloadData()
        }
    }
    private var movieDetailsAttributes: [MovieDetailsAttribute]
    private var movieDetails: [MovieDetail]
    private var movieCast: [MovieCast]
    private var movieReviews: [MovieReview]
    
    init() {
        selectedMovieAttribute = .about
        movieDetailsAttributes = []
        movieDetails = []
        movieCast = []
        movieReviews = []
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setCollectionViewLayout(setupLayout(), animated: true)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .appTheme.background
        registerCells()
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Collection View Cells
    private func registerCells() {
        register(MovieAboutCell.self, forCellWithReuseIdentifier: "\(MovieAboutCell.self)")
        register(MovieReviewCell.self, forCellWithReuseIdentifier: "\(MovieReviewCell.self)")
        register(MovieCastCell.self, forCellWithReuseIdentifier: "\(MovieCastCell.self)")
        register(MovieOverviewCell.self, forCellWithReuseIdentifier: "\(MovieOverviewCell.self)")
        register(MovieFilterAttributeCell.self, forCellWithReuseIdentifier: "\(MovieFilterAttributeCell.self)")
        register(BlankStateViewCell.self, forCellWithReuseIdentifier: "\(BlankStateViewCell.self)")
    }
    
    func configureMovieDetails(_ movieDetails: MovieDetail) {
        self.movieDetails.append(movieDetails)
        reloadData()
    }
    
    func configureMovieDetailsAttributes(_ attributes: [MovieDetailsAttribute]) {
        movieDetailsAttributes = attributes
    }
    
    func configureReviews(_ reviews: [MovieReview]) {
        movieReviews = reviews
        reloadData()
    }
    
    func configureCast(_ cast: [MovieCast]) {
        movieCast = cast
        reloadData()
    }
    
    // MARK: - Setup Collection View Layout
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // MARK: - Movie Detail Cell
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(310))
                return NSCollectionLayoutSection(
                    group: .horizontal(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                )
            }
            // MARK: - Movie Detail Section (About, Reviews, Cast)
            else if sectionIndex == 1 {
                let layoutSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
                let section = NSCollectionLayoutSection(
                    group: .horizontal(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                )
                section.interGroupSpacing = 18
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 25, leading: 20, bottom: 0, trailing: 20)
                return section
                
            } else if sectionIndex == 2 {
                switch self.selectedMovieAttribute {
                case .about:
                    let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                    let section = NSCollectionLayoutSection(
                        group: .horizontal(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                    )
                    section.contentInsets = .init(top: 25, leading: 20, bottom: 20, trailing: 20)
                    return section
                case .reviews:
                    let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                    let section = NSCollectionLayoutSection(
                        group: .vertical(layoutSize: layoutSize, subitems: [.init(layoutSize: layoutSize)])
                    )
                    section.interGroupSpacing = 12
                    section.contentInsets = .init(top: 25, leading: 20, bottom: 20, trailing: 20)
                    return section
                case .cast:
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    group.interItemSpacing = .flexible(65)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    section.interGroupSpacing = 24
                    section.contentInsets = .init(top: 25, leading: 20, bottom: 20, trailing: 20)
                    return section
                }
            }
            return nil
        }
    }
}

// MARK: - MovieDetailsCollectionViewDataSource Configuration
extension MovieDetailsCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movieDetails.count
        case 1:
            return movieDetailsAttributes.count
        case 2:
            switch selectedMovieAttribute {
            case .about:
                return movieDetails.count
            case .reviews:
                return movieReviews.count == 0 ? 1 : movieReviews.count // return 1 if no reviews added for Blank State View
            case .cast:
                return movieCast.count
            }
        default:
            assert(false, "Invalid Element Type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieOverviewCell.self)", for: indexPath) as! MovieOverviewCell
            let movie = movieDetails[indexPath.item]
            cell.configure(
                title: movie.title,
                releaseDate: movie.releaseDate,
                playingTime: movie.runtime,
                popularity: movie.popularity,
                genre: movie.genres.first?.name ?? "",
                backgdropImage: movie.backdropUrl,
                posterImage: movie.posterUrl
            )
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieFilterAttributeCell.self)", for: indexPath) as! MovieFilterAttributeCell
            let attribute = movieDetailsAttributes[indexPath.item]
            cell.configure(title: attribute.rawValue , isSelected: selectedMovieAttribute == attribute)
            return cell
        case 2:
            switch selectedMovieAttribute {
            case .about:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieAboutCell.self)", for: indexPath) as! MovieAboutCell
                let movie = movieDetails[indexPath.item]
                cell.configure(about: movie.overview)
                return cell
            case .reviews:
                if movieReviews.count == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BlankStateViewCell.self)", for: indexPath) as! BlankStateViewCell
                    cell.configure(with: .init(
                        title: "No Movie Reviews Found",
                        subTitle: "There are no reviews added for this movie",
                        icon: .icons.noResult
                    ))
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieReviewCell.self)", for: indexPath) as! MovieReviewCell
                    let review = movieReviews[indexPath.item]
                    cell.configure(
                        authorName: review.authorDetails.name,
                        reviewContent: review.content,
                        avatar: review.authorDetails.avatarUrl,
                        rating: review.authorDetails.rating ?? 0
                    )
                    return cell
                }
            case .cast:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCastCell.self)", for: indexPath) as! MovieCastCell
                let cast = movieCast[indexPath.item]
                cell.configure(profile: cast.profileUrl, name: cast.name)
                return cell
            }
        default:
            assert(false, "Invalid Element Type")
        }
    }
    
    
}

// MARK: MovieDetailsCollectionViewDelegate Configuration
extension MovieDetailsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedMovieAttribute = movieDetailsAttributes[indexPath.item]
            switch selectedMovieAttribute {
            case .cast:
                movieDetailsCollectionViewDelegate?.didSelectedMovieCast()
            case .reviews:
                movieDetailsCollectionViewDelegate?.didSelectedMovieReviews()
            default:
                break
            }
        }
    }
}
