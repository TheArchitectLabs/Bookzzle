//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct EditionView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(NotificationService.self) private var ns
    @Environment(OpenLibraryService.self) private var ols
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query private var books: [Book]
    @Query private var authors: [Author]
    @State private var entries: [OLEditionEntry] = []
    @State private var showMissingCovers: Bool = false
    
    @State private var cover: Int = 0
    
    // Required to add a new book
    @State private var workKey: String = ""
    @State private var title: String = ""
    @State private var isbn10: String = ""
    @State private var isbn13: String = ""
    @State private var firstSentence: String = ""
    @State private var numberOfPages: Int = 0
    @State private var firstPublishYear: Int = 0
    @State private var publisher: String = ""
    @State private var status: Status.RawValue = Status.onshelf.rawValue
    @State private var coverPhoto: Data? = nil
    
    // Required to add a new author
    @State private var authorKey: [String] = []
//    @State private var authorName: String = ""
//    @State private var authorBio: String = ""
//    @State private var authorBirthDate: String = ""
//    @State private var authorDeathDate: String = ""
//    @State private var imdbID: String = ""
//    @State private var goodReadsID: String = ""
//    @State private var amazonID: String = ""
//    @State private var libraryThingID: String = ""
//    @State private var authorPhoto: Data? = nil
    
    let work: OLWorksDocs
    let key: String
    
    var filteredEntries: [OLEditionEntry] {
        showMissingCovers ? entries : entries.filter { $0.covers != nil }
    }
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                HeaderTitle()
                HStack(alignment: .center) {
                    backButton()
                    Text("Editions")
                        .subHeaderTitleViewModifier()
                    backButton().hidden()
                }
                .font(.title)
                .padding(.bottom, 15)
                
                workView(work: work)
                
                Button("\(showMissingCovers ? "Hide" : "Show") Missing Covers", systemImage: showMissingCovers ? "checkmark.square" : "square") {
                    withAnimation {
                        showMissingCovers.toggle()
                    }
                }
                .foregroundStyle(.primary)
                .font(.headline)
                .background(.green.opacity(0.4))
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                List {
                    ForEach(filteredEntries) { entry in
                        EditionListRow(edition: entry)
                            .padding(.bottom, 5)
                            .onTapGesture {
                                updateWorkToAdd(entry: entry)
                            }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .task {
                    do {
                        entries = try await ols.fetchEdition(key: key, limit: 100, offset: 0)
                        getData()
                    } catch {
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - METHODS
    func getData() {
        workKey = work.key
        title = work.title
        authorKey = work.authorKey ?? []
        
        // TODO: What if isbn has more than 1 isbn10 or 13?
        if let isbn = work.isbn {
            isbn.forEach { isbn in
                if isbn.count == 10 {
                    isbn10 = isbn
                } else if isbn.count == 13 {
                    isbn13 = isbn
                } else {
                    // do nothing
                }
            }
        }
        
        if let firstSentence = work.firstSentence {
            self.firstSentence = firstSentence.first ?? ""
        }
        
        if let pages = work.numberOfPagesMedian {
            numberOfPages = pages
        }
        
        if let year = work.firstPublishYear {
            firstPublishYear = year
        }
        
        if let cover = work.coverI {
            self.cover = cover
        }
        
        if entries.count == 1 {
            updateWorkToAdd(entry: entries.first!)
        }
    }
    
    func updateWorkToAdd(entry: OLEditionEntry) {
        isbn10 = entry.isbn10?.joined(separator: ", ") ?? "Unknown"
        isbn13 = entry.isbn13?.joined(separator: ", ") ?? "Unknown"
        publisher = entry.publishers?.joined(separator: ", ") ?? "Unknown"
        cover = entry.covers?.first ?? 0
    }
    
    func add() {
        
        // Check to make sure the book doesn't already exist in the library
        guard !books.contains(where: { book in
            book.isbn13 == self.isbn13 ||
            book.isbn10 == self.isbn10
        }) else { return }
        
        // Check to make sure the author doesn't alresdy exist in the library
        authorKey.forEach { key in
            guard !authors.contains(where: { author in
                author.authorKey == key
            }) else { return }
        }
        
        
    }
    
    // MARK: - EXTRACTED VIEWS
    func backButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left.circle")
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(Circle())
        }
    }
    
    func workImage(width: CGFloat, height: CGFloat) -> some View {
        CachedAsyncImage(
            url: URL(string: "https://covers.openlibrary.org/a/id/\(cover)-L.jpg?default=false"),
            transaction: Transaction(animation: .bouncy(duration: 1))
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
//                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: width, height: height)
            case .failure:
                ZStack {
                    Color.black.opacity(0.1)
                    VStack {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                        Text("No Photo Available")
                            .multilineTextAlignment(.center)
                            .font(.caption)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: width, height: height)
            @unknown default:
                fatalError()
            }
        }
    }
    
    func workView(work: OLWorksDocs) -> some View {
        HStack(spacing: 10) {
            workImage(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(.primary)
                Text(work.uAuthorName)
//                Text(workKey)
//                Text("ISBN-10: \(isbn10)")
                Text("ISBN: \(isbn13)")
//                Text("First Sentence: \(firstSentence)")
                Text("Number of Pages: \(numberOfPages)")
                Text("First Publish Year: \(String(firstPublishYear))")
//                Text("Publisher: \(publisher)")
//                Text("-------------------------")
//                Text("CoverI: \(cover)")
//                Text("Cover Edition Key: \(work.coverEditionKey ?? "N/A")")
//                Text("-------------------------")
//                Text("Author Key: \(authorKey)")
//                Text("Author Name: \(authorName)")
                
            }
            .lineLimit(1)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(alignment: .bottomTrailing) {
            Button("Add") {
                
            }
            .buttonStyle(.borderedProminent)
            .padding(10)
        }
        
    }
}

// MARK: - PREVIEW
#Preview {
    let work: OLWorksDocs = OLWorksDocs.sample[0]
    let key: String = OLWorksDocs.sample[0].key
    
    EditionView(work: work, key: key)
        .environment(OpenLibraryService())
        .environment(NotificationService())
        .preferredColorScheme(.dark)
}
