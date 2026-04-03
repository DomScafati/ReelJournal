//
//  MovieService.swift
//  ReelJournal
//
//  Created by Dom S on 4/3/26.
//

import Foundation
let TMDBBaseURLString = "https://api.themoviedb.org/3"

protocol MovieServiceProtocol {
    func fetchMovies(_ endpoint: Endpoint) async throws -> MovieResponse
}

enum TMDBResponseError: Error {
    // Authentication
    case invalidAPIKey
    case authenticationFailed
    case sessionDenied

    // Request errors
    case invalidID
    case invalidParameters
    case methodNotFound
    case resourceNotFound

    // Server errors
    case serverError
    case serviceOffline
    case suspended

    // Rate limiting
    case rateLimitExceeded

    // Networking (our own additions, not TMDB's)
    case invalidResponse
    case decodingFailed
    case unknown(Int, String)
}

class MovieService: MovieServiceProtocol {
    func fetchMovies(_ endpoint: Endpoint) async throws -> MovieResponse {
        guard let url = URL(string: endpoint.rawValue) else {
            throw TMDBResponseError.invalidParameters
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpURLResponse = response as? HTTPURLResponse,
              (200...300).contains(httpURLResponse.statusCode) else {
            throw TMDBResponseError.invalidResponse
        }
        
        guard let movies = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
            throw TMDBResponseError.decodingFailed
        }

        return movies
    }
}
