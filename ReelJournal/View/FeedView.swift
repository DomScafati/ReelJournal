//
//  FeedView.swift
//  ReelJournal
//
//  Created by Dom S on 4/6/26.
//

import SwiftUI

struct FeedView: View {
    @Environment(Router.self) var router
    @State var shouldShow: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("ReelJournal")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                
                Spacer()
                
                Button {
                    shouldShow.toggle()
                }label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                        .background {
                            Capsule(style: .circular)
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.mainGold1)
                        }
                }
                .sheet(isPresented: $shouldShow) {
                    EntryView(shouldShow: $shouldShow)
                        .presentationDetents([.medium])
                }
            }
            .padding()
            
            Divider()
                .background(.mainGold1)
            
            ScrollView {
                LazyVStack {
                    PostedEntryCard()
                    Divider()
                        .background(.mainGold1)
                }
                .listRowSeparator(.hidden)
            }
        }
    }
}

struct PostedEntryCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("January 2nd, 2003")
                    .font(.system(
                        size: 16.0,
                        weight: .light,
                        design: .serif
                    ))
                    .foregroundStyle(.subtitleFontGrey)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .symbolRenderingMode(.hierarchical)
                        .tint(.mainGold1)
                }
            }
            .padding()
            
            EntryMovieCard()
            Text("I like dis moobie")
            Divider()
                .background(.mainGold1)
            TagList()
        }
    }
}

struct EntryView: View {
    @Binding var shouldShow: Bool
    @State var entryBody: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                EntryMovieCard()
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $entryBody)
                        .scrollContentBackground(.hidden)
                        .padding()
                    
                    if entryBody.isEmpty {
                        Text("What did you think?")
                            .foregroundStyle(.secondary)
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle("Movie Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { shouldShow.toggle() }
                }
                
                ToolbarItem {
                    Button("Post") { }
                        .background {
                            Capsule(style: .circular)
                        }
                }
            }
        }
    }
}

struct EntryMovieCard: View {
    var body: some View {
        // Movie info card
        HStack {
            Image("image_0019") // movie poster
                .padding()
            
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 1.0)
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Movie Title Here" ) // search bar that allows for quick lookup?
                    
                    Text("(2001)")
                }
                .padding(.bottom)
                
                Text("Rating: *****") // star rating. Set the general rating as the default. when default rating is applied, make the color desaturated.
                
                Text("seen: January/2001") // autofill todays date, but allow user to change this. Month/YYYY
            }
            .padding()
            
            Spacer(minLength: 40)
            
        }
        .background {
            RoundedRectangle(cornerRadius: 14.0)
                .foregroundStyle(.secondaryCharcoal)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct TagList: View {
    var body: some View {
        Text("#"+"Lynch")
            .foregroundStyle(.mainFontRegular)
            .padding(.vertical, 5)
            .padding(.horizontal)
            .background {
                Capsule(style: .circular)
                    .foregroundStyle(.tintedGold1)
            }
        
    }
}

#Preview {
    FeedView()
        .environment(Router())
}
