//
//  EntryView.swift
//  ReelJournal
//
//  Created by Dom S on 4/26/26.
//

import SwiftUI

struct EntryEditorView: View {
    let viewModel: FeedViewModel
    @Binding var shouldShow: Bool
    @State var entryBody: String = "" // needed as a buffer for text editor, cannot pass selectedEntry.body into it.
    @State var tags: [String] = []
    @State var newTag: String = ""
    
    var selectedEntry: JournalEntry?

    var body: some View {
        NavigationStack {
            VStack {
                EntryMovieHeaderView(entry: selectedEntry)
                
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
                Divider()
                    .background(.mainGold1)
                VStack {
                    TextField(text: $newTag) {
                        Text("Enter Tags")
                    }
                    .onSubmit {
                        tags.append(newTag)
                        newTag = ""
                    }

                    if tags.isEmpty {
                        Spacer()
                            .frame(height: 38)
                    } else {
                        TagList(tags: tags)
                            .onTapGesture {
                                //TODO: rework deleting tags. for now, we will delete on tap!
                                tags = []
                            }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            .navigationTitle("Movie Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { shouldShow.toggle() }
                }
                
                ToolbarItem {
                    Button(selectedEntry != nil ? "Update" : "Post") {
                        
                        if !entryBody.isEmpty {
                            if let entry = selectedEntry {
                                // updating existing entry
                                entry.body = entryBody
                                entry.tags = tags
                                viewModel.save()
                            } else {
                                // creating a new entry
                                let newEntry = JournalEntry(
                                    body: entryBody,
                                    tags: tags
                                )
                                
                                viewModel.add(newEntry)
                            }
                            viewModel.loadEntries()
                            shouldShow.toggle()
                        }
                    }
                    .background {
                        Capsule(style: .circular)
                    }
                }
            }
            .onAppear {
                entryBody = selectedEntry?.body ?? ""
                tags = selectedEntry?.tags ?? []
            }
        }
    }
}

struct EntryMovieHeaderView: View {
    let entry: JournalEntry? // will be nil if creating an entry
    
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
                    Text(entry?.movieTitle ?? "") // search bar that allows for quick lookup?
                    
                    Text(String(describing:entry?.releaseDate))
                }
                .padding(.bottom)
                
                Text("Rating: \(entry?.rating)") // star rating. Set the general rating as the default. when default rating is applied, make the color desaturated.
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
    var tags: [String]
    
    var body: some View {
        HStack {
    // ForEach tag in the tag list, display it inline.
            ForEach(tags, id: \.self) { tag in
                Text("#\(tag)")
                    .foregroundStyle(.mainFontRegular)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule(style: .circular)
                            .foregroundStyle(.tintedGold1)
                    }
            }
        }
    }
}
