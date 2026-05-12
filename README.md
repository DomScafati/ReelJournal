# ReelJournal

A personal movie journaling app inspired by Letterboxd, built with SwiftUI. Log films, write journal entries, and explore new movies — all in one place.

> Currently in active MVP development.

---

## App Overview

ReelJournal lets users browse movies, write personal journal entries tied to films they've watched, and manage their viewing history — combining the discovery experience of a movie database with the intimacy of a personal journal.

---

## Screens & Features

### Journal Feed
- ✅ Scrollable feed of all journal entries
- ✅ Entry cards showing movie title, body text, date, and tags
- ✅ Create, edit, and delete entries via sheet modal
- ⬜ Star rating input in entry composer
- ⬜ Tag input and persistence in entry composer
- ⬜ Movie selection wired into entry composer

### Movie Browser
- ✅ Fetch and display popular movies from TMDB
- ⬜ Search movies by title
- ⬜ Genre filter chips
- ⬜ Pagination on scroll

### Movie Detail
- ⬜ Full movie info (poster, overview, release date, rating, cast)
- ⬜ Write journal entry CTA

### Settings
- ⬜ Display name (editable, persisted)
- ⬜ Appearance toggle (light / dark / system)
- ⬜ Favorites list

---

## Tech Stack & Architecture

| Concern | Approach |
|---|---|
| UI | SwiftUI |
| Architecture | MVVM + Repository Pattern |
| Networking | URLSession + async/await |
| Movie Data | TMDB API (free tier) |
| Journal Persistence | SwiftData |
| Settings & Favorites | UserDefaults (planned) |
| Concurrency | Swift structured concurrency (`async/await`, `Task`, `@MainActor`) |
| Logging | Custom `DebugLogger` with severity levels (DEBUG/Testing only) |
| UI Testing | XCTest + Robot Pattern, in-memory SwiftData for test isolation |

---

## Project Structure

```
ReelJournal/
├── View/
│   ├── ReelJournalApp.swift
│   ├── RootView.swift
│   ├── MovieBrowserView.swift
│   ├── SettingView.swift
│   └── Feed/
│       ├── FeedView.swift
│       └── EntryView.swift
├── ViewModel/
│   ├── FeedViewModel.swift
│   └── MovieBrowserViewModel.swift
├── Repository/
│   ├── FeedRepository.swift
│   └── MovieBrowserRepository.swift
├── Networking/
│   ├── MovieService.swift
│   └── TMDBURL.swift
├── Model/
│   ├── JournalEntry.swift
│   ├── Movie.swift
│   └── AccessibilityIdentifiers.swift
├── Navigation/
│   ├── Router.swift
│   └── Screen.swift
└── Utility/
    ├── DebugLogger.swift
    ├── Secrets.swift
    └── GlobalProperties.swift
```

---

## Data Models

```swift
// SwiftData — Journal Entry
@Model class JournalEntry {
    var movieTitle: String
    var movieDirector: String
    var posterPath: String?
    var releaseDate: String
    var dateWatched: Date
    var rating: Float
    var body: String
    var tags: [String]
}

// TMDB API — Movie (Decodable, not persisted)
struct Movie: Decodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var releaseDate: String
    var genreIds: [Int]
    var voteAverage: Double
}
```

---

## API — TMDB

Free API. Requires a free account to get an API key.

| Endpoint | Purpose |
|---|---|
| `GET /discover/movie` | Popular movies feed |
| `GET /search/movie` | Search by title |
| `GET /genre/movie/list` | Genre filter list |
| `GET /movie/{id}` | Full movie detail |
| `GET /movie/{id}/credits` | Cast & crew |

---

## Getting Started

1. Clone the repo
2. Get a free API key from [themoviedb.org](https://www.themoviedb.org/)
3. Add your Bearer token to a `Secrets.plist` (not committed to git)
4. Build and run on iOS 17+ / Xcode 15+
