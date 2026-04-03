//
//  TMDBURL.swift
//  ReelJournal
//
//  Created by Dom S on 4/3/26.
//

import Foundation

enum Endpoint: String {
    case discover = "/discover/movie"
    case genre = "/genre/movie/list"
    case search = "/search/movie"
    case popular = "/movie/popular"
    case credits = "/movie/{id}/credits"
}
