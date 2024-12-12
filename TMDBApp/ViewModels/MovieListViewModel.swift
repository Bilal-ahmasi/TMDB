//
//  MovieListViewModel.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func fetchPopularMovies() {
        isLoading = true
        repository.getPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
