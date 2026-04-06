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
    }
}

struct FeedView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Text("")
    }
}

struct MovieBrowserView: View {
    @Environment(Router.self) var router
    @State var viewModel: MovieBrowserViewModel = MovieBrowserViewModel(MovieBrowserRepository(MovieService()))
    
    init() {
        _viewModel = State(wrappedValue: MovieBrowserViewModel(MovieBrowserRepository(MovieService())))
    }
    
    var body: some View {
        VStack {
            Button {
                router.push(.movieDetail)
            } label: {
                Text("Go To Details")
            }
            .padding()
            
            Button {
                router.push(.favorites)
            } label: {
                Text("Go To Favorites")
            }
            .padding()
            
            List {
                ForEach(viewModel.movies) { movie in
                    Text(movie.title)
                }
            }
        }
        .task {
            viewModel.getMovies()
        }
    }
}

struct MovieDetailView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Button {
            router.pop()
        } label: {
            Text("Go To Browser")
        }
    }
}

struct FavoritesView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Button {
            router.pop()
        } label: {
            Text("Go To Browser")
        }
    }
}

struct SettingsView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Text("")
    }
}

#Preview {
    FeedView()
}
