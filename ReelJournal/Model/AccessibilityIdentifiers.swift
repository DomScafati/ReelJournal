//
//  AccessibilityIdentifiers.swift
//  ReelJournal
//
//  Created by Dom S on 5/6/26.
//

import Foundation

enum FeedAccessibility: String {
    case addEntry
    
    var description: String {
        switch self {
        case .addEntry: return "FeedAccessibility.addEntry"
        default: return "FeedAccssibility"
        }
    }
}
