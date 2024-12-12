//
//  MovieDetailViewModel.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    private let movieID: Int

    init(movieID: Int, repository: MovieRepository) {
        self.movieID = movieID
        self.repository = repository
    }

    func fetchMovieDetails() {
        isLoading = true
        repository.getMovieDetails(movieID: movieID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let details):
                    self?.movieDetails = details
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
