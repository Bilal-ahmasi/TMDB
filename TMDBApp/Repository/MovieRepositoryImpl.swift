//
//  MovieRepositoryImpl.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchPopularMovies { result in
            completion(result)
        }
    }

    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        apiService.fetchMovieDetails(movieID: movieID) { result in
            completion(result)
        }
    }
}
