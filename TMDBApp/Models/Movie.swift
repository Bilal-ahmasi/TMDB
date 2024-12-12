//
//  Movie.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
}
