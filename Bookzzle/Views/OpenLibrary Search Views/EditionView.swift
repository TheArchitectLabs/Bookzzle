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
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    @Environment(OpenLibraryService.self) private var ols
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query private var books: [Book]
    @Query private var authors: [Author]
    @State private var entries: [OLEditionEntry] = []
    @State private var showMissingCovers: Bool = false
    
    @State private var hasBookBeenAdded: Bool = false
    
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
            
            if ns.showNotification {
                if let notification = ns.currentNotification {
                    VStack {
                        Spacer()
                        NotificationView(notification: notification)
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
    
    func add() async {
        // Check to make sure the book doesn't already exist in the library
        guard !books.contains(where: { $0.isbn13 == self.isbn13 || $0.isbn10 == self.isbn10 }) else {
            // Show a notification that the book already exists
            ns.show(type: .warning, title: BZNotification.bookDuplicate.description, message: BZNotification.bookDuplicate.message)
            return
        }
        
        // The book doesn't exist so let's get the data and set it up
        // Get the cover photo as data
        let url = URL(string: "https://covers.openlibrary.org/b/id/\(cover).jpg")
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            coverPhoto = data
        } catch {
            coverPhoto = nil
        }
        
        // Set up a new book
        let newBook: Book = Book(
            key: workKey,
            title: title,
            isbn10: isbn10,
            isbn13: isbn13,
            firstSentence: firstSentence,
            numberOfPages: numberOfPages,
            firstPublishYear: firstPublishYear,
            publisher: publisher,
            status: status,
            coverPhoto: coverPhoto
        )
        
        // Check to make sure the author doesn't alresdy exist in the library
        // AuthorKey can contain multiple authors. We want to check each one and
        // add the book to each author if necessary
        var addedToAuthor: Bool = false
        authorKey.forEach { key in
            let compareKey: String = "/authors/\(key)"
            authors.forEach { author in
                if author.authorKey == compareKey {
                    // This author exists. Add the book to this author
                    author.books.append(newBook)
                    try? context.save()
                    ns.show(type: .success, title: BZNotification.bookAdded(title: title).description, message: BZNotification.bookAdded(title: title).message)
                    addedToAuthor = true
                }
            }
        }
        
        // Check to make sure we didn't add the book to an author
        guard !addedToAuthor else { return }
        
        // If we are here, then we need to add the author(s) and the book
        // We already have the newBook ready. Let's create the authors...
        // We will have to use the authorKey to retrieve the data from OpenLibrary
        authorKey.forEach { key in
            Task {
                do {
                    // Retrieve the author
                    let result: OLAuthor = try await ols.fetchAuthor(id: key)
                    let newAuthor: Author = Author(authorKey: result.key, authorName: result.name, authorBio: result.bio?.value ?? "", authorBirthDate: result.birthDate ?? "", authorDeathDate: result.deathDate ?? "", imdbID: result.remoteIDS?.imdb ?? "", goodReadsID: result.remoteIDS?.goodreads ?? "", amazonID: result.remoteIDS?.amazon ?? "", libraryThingID: result.remoteIDS?.librarything ?? "", authorPhoto: nil)
                    
                    // Retrieve the author photo
                    let url = URL(string: "https://covers.openlibrary.org/a/olid/\(key)-L.jpg")
                    do {
                        let (data, _) = try await URLSession.shared.data(from: url!)
                        coverPhoto = data
                    } catch {
                        coverPhoto = nil
                    }
                    
                    // Assign the photo to the author
                    newAuthor.authorPhoto = coverPhoto
                    
                    // Append the book to the author
                    newAuthor.books.append(newBook)
                    
                    // Inseert the author
                    context.insert(newAuthor)
                    try? context.save()
                    ns.show(type: .success, title: BZNotification.bookAdded(title: title).description, message: BZNotification.bookAdded(title: title).message)
                } catch BZNotification.invalidURL {
                    ns.show(
                        type: .error,
                        title: BZNotification.invalidURL.description,
                        message: BZNotification.invalidURL.message,
                        duration: BZNotification.invalidURL.duration
                    )
                } catch BZNotification.invalidStatusCode(let statusCode) {
                    ns.show(
                        type: .error,
                        title: BZNotification.invalidStatusCode(code: statusCode).description,
                        message: BZNotification.invalidStatusCode(code: statusCode).message,
                        duration: BZNotification.invalidStatusCode(code: statusCode).duration
                    )
                } catch BZNotification.failedToDecode {
                    ns.show(
                        type: .error,
                        title: BZNotification.failedToDecode.description,
                        message: BZNotification.failedToDecode.message,
                        duration: BZNotification.failedToDecode.duration
                    )
                } catch BZNotification.invalidData {
                    ns.show(
                        type: .error,
                        title: BZNotification.invalidData.description,
                        message: BZNotification.invalidData.message,
                        duration: BZNotification.invalidData.duration
                    )
                } catch {
                    ns.show(
                        type: .error,
                        title: BZNotification.unknown.description,
                        message: BZNotification.unknown.message,
                        duration: BZNotification.unknown.duration
                    )
                }
            }
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
            Button(hasBookBeenAdded ? "Added" : "Add") {
                Task {
                    await add()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(10)
            .disabled(hasBookBeenAdded)
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
