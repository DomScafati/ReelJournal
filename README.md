#🎬 CineLog — Movie Journal App

A personal movie journaling app inspired by Letterboxd, built with SwiftUI. Log films, write journal entries, and explore new movies — all in one place.


## 📱 App Overview
CineLog lets users browse movies, save their favorites, and write personal journal entries tied to the films they watch. The app combines the discovery experience of a movie database with the intimacy of a personal journal.

## 🗺️ Screens & Features
1. Journal Feed (Main Tab)

Social media–style scrollable feed of all journal entries
Each entry card shows: movie poster thumbnail, movie title, star rating, entry date, and a journal excerpt
Entries sorted by most recent
Tap an entry to expand it to a full journal detail view

2. Movies Page

Collection view (LazyVGrid) displaying movie posters
Filter by genre using a horizontally scrollable chip/pill selector
Search bar with debounced input to avoid excessive API calls
Pagination — loads more movies as the user scrolls to the bottom
Tap a movie to go to its Detail Page

3. Movie Detail Page

Full movie info pulled from the TMDB API (poster, title, overview, release date, genres, runtime, rating, cast — subject to what the API provides)
"Add to Favorites" button — persisted with UserDefaults
"Write Journal Entry" CTA — opens the journal entry composer for this movie

4. Journal Entry Composer

Text editor for freeform journaling
Star rating picker (1–5)
Watch date selector
Tied to the movie via its TMDB ID
Data persisted with SwiftData

5. Settings Page

Display name (editable, persisted with UserDefaults)
Light / Dark / System appearance toggle (persisted with UserDefaults)
Favorites section preview with link to a full favorites list


## 🛠️ Tech Stack & Architecture
ConcernApproachUISwiftUIArchitectureMVVMNetworkingURLSession + async/await (modern concurrency)Movie DataTMDB API (free tier)Journal PersistenceSwiftDataSettings & FavoritesUserDefaultsConcurrencySwift structured concurrency (async/await, Task, @MainActor)PaginationCursor/page-based, triggered by scroll proximityDebounceCustom debounce on search using Task + try await Task.sleep

## 🏗️ Project Structure (Proposed)
CineLog/
├── App/
│   └── CineLogApp.swift
├── Core/
│   ├── Networking/
│   │   ├── NetworkService.swift        # URLSession wrapper, generic request method
│   │   ├── Endpoint.swift              # Enum of all TMDB endpoints
│   │   └── NetworkError.swift
│   ├── Persistence/
│   │   ├── SwiftDataModels.swift       # JournalEntry model
│   │   └── UserDefaultsManager.swift  # Typed keys for settings & favorites
├── Features/
│   ├── Feed/
│   │   ├── FeedView.swift
│   │   └── FeedViewModel.swift
│   ├── Movies/
│   │   ├── MoviesView.swift
│   │   ├── MoviesViewModel.swift       # Handles search debounce & pagination
│   │   └── MovieDetailView.swift
│   ├── Journal/
│   │   ├── JournalEntryView.swift
│   │   └── JournalEntryViewModel.swift
│   └── Settings/
│       └── SettingsView.swift
├── Shared/
│   ├── Views/
│   │   ├── MoviePosterCard.swift
│   │   ├── JournalEntryCard.swift
│   │   └── StarRatingView.swift
│   └── Models/
│       ├── Movie.swift                 # Decodable TMDB response models
│       └── Genre.swift

## 🔌 API — TMDB (The Movie Database)
Free API. Requires a free account to get an API key.
Likely endpoints used:

GET /movie/popular — Popular movies (main grid, paginated)
GET /search/movie — Search by title
GET /genre/movie/list — All genres for filter chips
GET /discover/movie?with_genres={id} — Filter movies by genre
GET /movie/{id} — Full movie detail (runtime, cast, tagline, etc.)
GET /movie/{id}/credits — Cast & crew


## 📝 Full detail page fields will be confirmed once the API is explored during development.


## 💾 Data Models (Sketch)
swift// SwiftData — Journal Entry
@Model class JournalEntry {
    var id: UUID
    var movieId: Int          // TMDB movie ID
    var movieTitle: String
    var posterPath: String?
    var body: String
    var rating: Int           // 1–5
    var watchedDate: Date
    var createdAt: Date
}

// UserDefaults — Settings
struct AppSettings {
    var displayName: String        // key: "display_name"
    var colorScheme: String        // key: "color_scheme" ("light"/"dark"/"system")
    var favoriteMovieIds: [Int]    // key: "favorite_ids"
}

## ✅ MVP Scope (What's In)

 Journal feed with all entries
 Movie grid with search, genre filter, and pagination
 Movie detail page
 Journal entry composer linked to a movie
 Favorites saved with UserDefaults
 Settings (name + appearance) saved with UserDefaults
 Networking layer with async/await
 Search debounce

## 🔮 Post-MVP Ideas

iCloud sync for journal entries
Watchlist feature
Movie recommendations based on favorites
Widget showing your last watched film
Charts view — genres watched over time


## 🚀 Getting Started

Clone the repo
Get a free API key from themoviedb.org
Add your key to a Secrets.plist (not committed to git)
Build and run on iOS 17+ / Xcode 15+
