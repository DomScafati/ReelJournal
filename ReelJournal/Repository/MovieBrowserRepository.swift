//
//  MovieBrowserRepository.swift
//  ReelJournal
//
//  Created by Dom S on 4/5/26.
//

import Foundation

protocol MovieBrowserRepositoryProtocol {
    var movies: [Movie]? {get async}
    func fetchMovies() async
}

class MovieBrowserRepository: MovieBrowserRepositoryProtocol {
    let service: MovieServiceProtocol
    var movieResponse: MovieResponse?
    var movies: [Movie]?

    init(_ service: MovieServiceProtocol) {
        self.service = service
    }

    func fetchMovies() async {
            do {
                movieResponse = try await service.fetchMovies(.discover)
                movies = movieResponse?.results
            } catch {
                //TODO: handle errors
                print(error)
            }
    }
}
