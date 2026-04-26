//
//  ReelJournalApp.swift
//  ReelJournal
//
//  Created by Dom S on 4/1/26.
//

import SwiftUI
import SwiftData

@main
struct ReelJournalApp: App {
    let journalContainer = try! ModelContainer(for: JournalEntry.self)
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(journalContainer)
    }
}
