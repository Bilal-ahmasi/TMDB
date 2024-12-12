//
//  MovieRepository.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation

protocol MovieRepository {
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}
