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
    @State var rating: Double = 0
    
    var selectedEntry: JournalEntry?
    
    var body: some View {
        NavigationStack {
            VStack {
                EntryMovieHeaderView(
                    entry: selectedEntry,
                    ratingInterationEnabled: true,
                    rating: $rating
                )
                
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
                                entry.rating = rating
                                viewModel.save()
                            } else {
                                // creating a new entry
                                let newEntry = JournalEntry(
                                    rating: rating,
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
                rating = selectedEntry?.rating ?? 0
            }
        }
    }
}

struct EntryMovieHeaderView: View {
    let entry: JournalEntry? // will be nil if creating an entry
    let ratingInterationEnabled: Bool
    @Binding var rating: Double

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
                
                StarRatingView(
                    rating: $rating,
                    interactionEnabled: ratingInterationEnabled
                )
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

struct StarRatingView: View {
    @Binding var rating: Double
    let maxRating: Int = 5
    let interactionEnabled: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { index in
                StarView(fillAmount: fillAmount(for: index))
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if interactionEnabled {
                        let x = value.location.x
                        // Determine which star and which half
                        let starWidth: CGFloat = 34  // width + spacing
                        let starIndex = Int(x / starWidth)
                        let remainder = x.truncatingRemainder(dividingBy: starWidth)
                        let isHalf = remainder < starWidth / 2
                        
                        rating = Double(starIndex) + (isHalf ? 0.5 : 1.0)
                    }
                }
                .onEnded { value in
                    
                }
        )
    }
    
    func fillAmount(for index: Int) -> Double {
        let diff = rating - Double(index - 1)
        return max(0, min(1, diff)) // clamp to 0...1
    }
}

struct StarView: View {
    let fillAmount: Double // 0 = empty, 0.5 = half, 1 = full
    
    var body: some View {
        ZStack {
            // Base empty star
            Image(systemName: "star")
                .foregroundStyle(.subtitleFontGrey)
            
            // Overlay filled star, clipped to fillAmount width
            GeometryReader { geo in
                Image(systemName: "star.fill")
                    .foregroundStyle(.mainGold1)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                // shrink the rect from the right
                    .mask {
                        Rectangle()
                            .frame(width: geo.size.width * fillAmount)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }
        }
        .frame(width: 30, height: 30)
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
