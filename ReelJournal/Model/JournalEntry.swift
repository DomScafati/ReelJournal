//
//  JournalEntry.swift
//  ReelJournal
//
//  Created by Dom S on 4/16/26.
//

import SwiftUI
import SwiftData

@Model
class JournalEntry {
    var movieTitle: String?
    var movieDirector: String?
    var posterPath: String?
    var releaseDate: Date?

    var dateWatched: Date?
    var rating: Float?
    var body: String?
    var tags: [String]?
    
    var dateWatchedString: String {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        guard let date = self.dateWatched else { return "" }
        return formatter.string(from: date)
    }
    
    init(
        movieTitle: String = "",
        movieDirector: String = "",
        posterPath: String = "",
        releaseDate: Date = Date(),
        dateWatched: Date = Date(),
        rating: Float? = nil,
        body: String? = nil,
        tags: [String]? = nil
    ) {
        self.movieTitle = movieTitle
        self.movieDirector = movieDirector
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.dateWatched = dateWatched
        self.rating = rating
        self.body = body
        self.tags = tags
    }
}
