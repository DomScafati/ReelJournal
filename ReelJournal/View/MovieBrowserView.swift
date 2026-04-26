//
//  MovieBrowserView.swift
//  ReelJournal
//
//  Created by Dom S on 4/6/26.
//

import SwiftUI

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
