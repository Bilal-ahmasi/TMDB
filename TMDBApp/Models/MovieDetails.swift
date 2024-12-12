//
//  MovieDetails.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
    let release_date: String?
    
    var posterURL: URL? {
        guard let posterPath = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
