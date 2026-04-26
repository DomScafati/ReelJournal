//
//  FeedRepository.swift
//  ReelJournal
//
//  Created by Dom S on 4/16/26.
//

import SwiftUI
import SwiftData

protocol FeedRepositoryProtocol {
    var context: ModelContext { get async }
    func fetchAll() -> [JournalEntry]
    func add(_ entry: JournalEntry)
    func delete(_ entry: JournalEntry)
    func save()
}

// handles the fetching and transforming of data
// Handles CRUD
// handles errors in class
class FeedRepository: FeedRepositoryProtocol {
    var context: ModelContext
        
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAll() -> [JournalEntry] {
        let descriptor = FetchDescriptor<JournalEntry>(sortBy: [SortDescriptor(\.dateWatched, order: .reverse)])
        do {
            return try context.fetch(descriptor)
        } catch {
            // handle error with ErrorLogger
        }
        return []
    }
    
    func add(_ entry: JournalEntry) {
        do {
            context.insert(entry)
            try context.save()
        } catch {
            // handle error with ErrorLogger
        }
    }
    
    func delete(_ entry: JournalEntry) {
        do {
            context.delete(entry)
            try context.save()
        } catch {
            // handle error with ErrorLogger
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            // handle error with ErrorLogger
        }
    }
}
