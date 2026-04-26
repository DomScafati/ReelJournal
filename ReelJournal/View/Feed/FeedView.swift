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
                    if let vm = viewModel {
                        EntryEditorView(viewModel: vm, shouldShow: $shouldShow)
                            .presentationDetents([.medium])
                    }

                }
            }
            .padding()
            
            Divider()
                .background(.mainGold1)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel?.entries ?? []) { entry in
                        FeedEntryCard(entry: entry)
                        Divider()
                            .background(.mainGold1)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .onAppear {
            let feedRepository = FeedRepository(context: context)
            if viewModel == nil {
                viewModel = FeedViewModel(repository: feedRepository)
            }
        }
    }
}

struct FeedEntryCard: View {
    let entry: JournalEntry
    
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
                
                Button {
                    
                } label: {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .symbolRenderingMode(.hierarchical)
                        .tint(.mainGold1)
                }
            }
            .padding()
            
            EntryMovieHeaderView(entry: entry)
            Text(entry.body ?? "")
            Divider()
                .background(.mainGold1)
            TagList()
        }
    }
}

#Preview {
    FeedView()
        .environment(Router())
        .modelContainer(try! ModelContainer(for: JournalEntry.self))
}
