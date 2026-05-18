//
//  FeedView.swift
//  ReelJournal
//
//  Created by Dom S on 4/6/26.
//

import SwiftUI
import SwiftData

struct FeedView: View {
    @Environment(Router.self) var router
    @Environment(\.modelContext) var context
    @State var viewModel: FeedViewModel?
    @State var selectedEntry: JournalEntry?
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
                        .accessibilityIdentifier(FeedAccessibility.addEntry.description)
                }
            }
            .padding()
            
            Divider()
                .background(.mainGold1)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel?.entries ?? []) { entry in
                        FeedEntryCard(
                            viewModel: viewModel!,
                            entry: entry,
                            selectedEntry: $selectedEntry,
                            shouldShow: $shouldShow
                        )
                    
                        Divider()
                            .background(.mainGold1)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .sheet(isPresented: $shouldShow, onDismiss: { selectedEntry = nil } ) {
            if let vm = viewModel {
                EntryEditorView(
                    viewModel: vm,
                    shouldShow: $shouldShow,
                    selectedEntry: selectedEntry
                )
                    .presentationDetents([.medium])
            }
            
        }
        .onAppear {
            let feedRepository = FeedRepository(context: context)
            if viewModel == nil {
                viewModel = FeedViewModel(repository: feedRepository)
            }
            
            viewModel?.loadEntries()
        }
    }
}

struct FeedEntryCard: View {
    let viewModel: FeedViewModel
    let entry: JournalEntry
    @Binding var selectedEntry: JournalEntry?
    @Binding var shouldShow: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(String(describing: entry.dateWatchedString))
                    .font(.system(
                        size: 16.0,
                        weight: .light,
                        design: .serif
                    ))
                    .foregroundStyle(.subtitleFontGrey)
                
                Spacer()
                
                Menu {
                    Button("Edit") {
                        selectedEntry = entry
                        shouldShow.toggle()
                    }
                    
                    Button("Delete", role: .destructive) { // add deletion animation at some point
                        viewModel.delete(entry)
                        viewModel.loadEntries()
                    }
                } label: {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .symbolRenderingMode(.hierarchical)
                        .tint(.mainGold1)
                }
                
            }
            .padding()
            
            FeedEntryHeaderView(entry: entry)
            
            Text(entry.body ?? "")
            Divider()
                .background(.mainGold1)
            TagList(tags: entry.tags ?? [])
        }
    }
}

struct FeedEntryHeaderView: View {
    let entry: JournalEntry // will be nil if creating an entry

    var body: some View {
        // Movie info card
        HStack {
            Image("") // movie poster
                .padding()
            
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 1.0)
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.movieTitle ?? "") // search bar that allows for quick lookup?
                    
                    if let date = entry.releaseDate {
                         Text(date, format: .dateTime.year())
                     }
                }
                
                .padding(.bottom)
                
                StarRatingView(
                    rating: Binding.constant(entry.rating ?? 0),
                    interactionEnabled: false
                )
            }
            .padding()
            
            Spacer()
            
        }
        .background {
            RoundedRectangle(cornerRadius: 14.0)
                .foregroundStyle(.secondaryCharcoal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    FeedView()
        .environment(Router())
        .modelContainer(try! ModelContainer(for: JournalEntry.self))
}
