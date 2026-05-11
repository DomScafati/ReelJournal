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
#if UITesting
    let journalContainer = try! ModelContainer(
        for: JournalEntry.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
#else
    let journalContainer = try! ModelContainer(for: JournalEntry.self)
#endif
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(journalContainer)
    }
}
