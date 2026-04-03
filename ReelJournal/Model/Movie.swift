//
//  Movie.swift
//  ReelJournal
//
//  Created by Dom S on 4/3/26.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages    = "total_pages"
        case totalResults  = "total_results"
    }
}

struct Movie: Decodable, Hashable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIds: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle    = "original_title"
        case overview
        case posterPath       = "poster_path"
        case backdropPath     = "backdrop_path"
        case releaseDate      = "release_date"
        case genreIds         = "genre_ids"
        case popularity
        case voteAverage      = "vote_average"
        case voteCount        = "vote_count"
        case originalLanguage = "original_language"
    }
}
