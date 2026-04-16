//
//  ContentView.swift
//  ReelJournal
//
//  Created by Dom S on 4/1/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var feedRouter = Router()
    @State private var moviesRouter = Router()
    @State private var settingsRouter = Router()
    
    var body: some View {
        TabView {
            Tab("Feed", systemImage: "film") {
                NavigationStack(path: $feedRouter.path) {
                    FeedView()
                        .navigationDestination(for: Screen.self) { screen in
                            // Further pages TBD
                        }
                }
                .environment(feedRouter)
                
            }
            
            Tab("Movies", systemImage: "popcorn") {
                NavigationStack(path: $moviesRouter.path) {
                    MovieBrowserView()
                        .navigationDestination(for: Screen.self) { screen in
                            switch screen {
                            case .favorites:
                                FavoritesView()
                            default:
                                MovieDetailView()
                            }
                        }
                }
                .environment(moviesRouter)
                
            }
            
            Tab("Settings", systemImage: "gearshape") {
                NavigationStack(path: $settingsRouter.path) {
                    SettingsView()
                        .navigationDestination(for: Screen.self) { screen in
                            // Further pages TBD
                        }
                }
                .environment(settingsRouter)
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
