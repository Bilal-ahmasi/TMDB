//
//  APIService.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation

protocol APIService {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}
