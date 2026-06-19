//
//  MovieSearchViewModel.swift
//  ReelJournal
//
//  Created by Dom S on 6/14/26.
//

import SwiftUI

@Observable
class MovieSearchViewModel {
    var moviesList: [Movie] = []
    var sortedList: [Movie] = []
    
    func fetchMovies() {
        
    }
}

protocol MovieSearchRepositoryProtocol {
    
}

class MovieSearchRepository: MovieSearchRepositoryProtocol {
    
}
