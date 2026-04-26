//
//  Secrets.swift
//  ReelJournal
//
//  Created by Dom S on 4/3/26.
//

import Foundation

struct Secrets {
    static let tmdbAccessToken: String = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let token = dict["TMDBAccessToken"] as? String else {
            fatalError("Secrets.plist missing or TMDBAccessToken not found")
        }
        return token
    }()
}
