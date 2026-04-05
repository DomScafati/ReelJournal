//
//  MovieBrowserViewModel.swift
//  ReelJournal
//
//  Created by Dom S on 4/5/26.
//

import SwiftUI

@Observable
class MovieBrowserViewModel {
    let repository: MovieBrowserRepositoryProtocol
    var movies: [Movie] = []
    
    init(_ repository: MovieBrowserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies() {

        Task {
            await repository.fetchMovies()
            guard let fetchedMovies = await repository.movies else {
                return
            }
            movies = fetchedMovies
        }
    }
}
