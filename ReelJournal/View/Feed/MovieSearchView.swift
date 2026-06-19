//
//  MovieSearchView.swift
//  ReelJournal
//
//  Created by Dom S on 6/11/26.
//

import SwiftUI

struct MovieSearchView: View {
    var viewModel = MovieSearchViewModel()
    var array = ["Movie 1", "Movie 2", "Movie 3"]
    @State var filteredMovies = ["1", "2", "3"]
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            
            HStack {
                
                TextField("Search movies", text: $searchText)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 14.0)
                            .foregroundStyle(.secondaryCharcoal)
                    }
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(array, id: \.self) { film in
                        MovieSearchCell()
                    }
                }
                
                Spacer()
            }
            .navigationTitle("What did you watch?")
            
        }
    }
}

struct MovieSearchCell: View {
    var posterString: String = "movieclapper"
    var movieTitle: String = "title"
    var yearReleased: String = "2001"
    var director: String = "David Lynch"
    
    var body: some View {
        HStack {
            
            Image(systemName: posterString)
                .padding(.trailing)
            
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 1.0)
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading){
                Text("Title")
                    .font(.system(
                        .title2,
                        design: .serif,
                        weight: .bold))
                
                Text("\(yearReleased) - \(director)")
                    .foregroundStyle(.subtitleFontGrey)
            }
            .padding(.leading)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 14.0)
                .foregroundStyle(.secondaryCharcoal)
        }
    }
}

#Preview {
    MovieSearchView()
        .preferredColorScheme(.dark)
    
}
