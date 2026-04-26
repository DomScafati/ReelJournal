//
//  FeedViewModel.swift
//  ReelJournal
//
//  Created by Dom S on 4/16/26.
//

import Foundation

@Observable
class FeedViewModel {
    let repository: FeedRepositoryProtocol
    var entries: [JournalEntry] = []

    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadEntries() {
        self.entries = repository.fetchAll()
    }
    
    func add(_ entry: JournalEntry) {
        repository.add(entry)
    }
    
    func save() {
        repository.save()
    }
    
    func delete(_ entry: JournalEntry) {
        repository.delete(entry)
    }
}
