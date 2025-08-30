//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("currentMedium") private var currentMedium: String = HomeMediumType.book.rawValue
    @AppStorage("currentViewType") private var currentViewType: String = HomeViewType.grid.rawValue
    @AppStorage("bookGridSaveState") private var bookGridSaveState: Bool = false
    @AppStorage("puzzleGridSaveState") private var puzzleGridSaveState: Bool = false
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var medium: HomeMediumType = .book
    @State private var viewType: HomeViewType = .grid
    @State private var isImportEnabled: Bool = false
    @State private var isExportEnabled: Bool = false
    @State private var authorCount: Int = 0
    @State private var bookCount: Int = 0
    @State private var puzzleCount: Int = 0
    @State private var isShowingWishlistOnly: Bool = false
    
    // MARK: - VIEW
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                VStack {
                    VStack(spacing: 0) {
                        HeaderTitle()
                        
                        HStack {
                            headerMenu()
                            subTitle()
                            if medium == .puzzle {
                                NavigationLink(destination: EmptyView()) {
                                    Image(systemName: "plus.circle")
                                        .background(.green)
                                        .clipShape(Circle())
                                }
                            } else {
                                NavigationLink(destination: OpenLibrarySearchView()) {
                                    Image(systemName: "plus.circle")
                                        .background(.green)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .font(.title)
                        .foregroundStyle(.primary)
                    }
                    DividingLine()
                    contentView()
                }
                .padding(.horizontal)
                
                if ns.showNotification {
                    if let notification = ns.currentNotification {
                        VStack {
                            Spacer()
                            NotificationView(notification: notification)
                        }
                    }
                }
            }
        }
        .task {
            medium = HomeMediumType(rawValue: currentMedium) ?? .book
            viewType = HomeViewType(rawValue: currentViewType) ?? .grid
            await setImportExportDelete()
        }
        .onChange(of: medium) { _, _ in
            currentMedium = medium.rawValue
            
            if medium == .book {
                viewType = bookGridSaveState == true ? .grid : .list
            } else if medium == .puzzle {
                viewType = puzzleGridSaveState == true ? .grid : .list
            } else {
                viewType = .list
            }
            
            Task { await setImportExportDelete() }
        }
        .onChange(of: viewType) { _, _ in
            currentViewType = viewType.rawValue
        }
        .onOpenURL(perform: handleIncomingURL)
    }
    
    // MARK: - EXTRACTED VIEWS
    func headerMenu() -> some View {
        Menu {
            Section {
                Button("User Profile", systemImage: "person.fill") { }
            }
            
            if medium != .author {
                Section {
                    Button("Wishlist Only", systemImage: "exclamationmark.shield") {
                        isShowingWishlistOnly.toggle()
                    }
                    .tint(isShowingWishlistOnly ? .green : .primary)
                }
            }
            
            Section {
                ControlGroup {
                    Button(HomeMediumType.author.rawValue.capitalized, systemImage: HomeMediumType.author.icon) {
                        medium = .author
                    }
                    .tint(medium == .author ? .green : .primary)
                    Button(HomeMediumType.book.rawValue.capitalized, systemImage: HomeMediumType.book.icon) {
                        medium = .book
                    }
                    .tint(medium == .book ? .green : .primary)
                    Button(HomeMediumType.puzzle.rawValue.capitalized, systemImage: HomeMediumType.puzzle.icon) {
                        medium = .puzzle
                    }
                    .tint(medium == .puzzle ? .green : .primary)
                }
            }
            
            Section {
                ControlGroup {
                    if medium != .author {
                        Button(HomeViewType.grid.rawValue.capitalized, systemImage: HomeViewType.grid.icon) {
                            viewType = .grid
                            if medium == .book {
                                bookGridSaveState = true
                            }
                            if medium == .puzzle {
                                puzzleGridSaveState = true
                            }
                        }
                        .tint(viewType == .grid ? .green : .primary)
                    }
                    Button(HomeViewType.list.rawValue.capitalized, systemImage: HomeViewType.list.icon) {
                        viewType = .list
                        if medium == .book {
                            bookGridSaveState = false
                        }
                        if medium == .puzzle {
                            puzzleGridSaveState = false
                        }
                    }
                    .tint(viewType == .list ? .green : .primary)
                }
            }
            
            Section("File Options") {
                ControlGroup {
                    if isImportEnabled {
                        Button("Import", systemImage: "square.and.arrow.down.fill") {
                            Task {
                                await importData()
                            }
                        }
                    }
                    if isExportEnabled {
                        Button("Export", systemImage: "square.and.arrow.up.fill") {
                            Task {
                                await exportData()
                            }
                        }
                    }
                    if isImportEnabled {
                        Button("Delete", systemImage: "delete.left.fill", role: .destructive) {
                            Task {
                                await deleteExports()
                            }
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.circle")
                .background(.green)
                .clipShape(Circle())
        }
    }
    
    func subTitle() -> some View {
        Text(medium.title)
            .font(.largeTitle)
            .fontWeight(.black)
            .fontDesign(.rounded)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .frame(maxWidth: .infinity)
    }
    
    func contentView() -> some View {
        Group {
            switch medium {
            case .author: AuthorListView(isExportEnabled: $isExportEnabled)
            case .book:
                if viewType == .grid {
                    BookGridView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
                } else {
                    BookListView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
                }
            case .puzzle:
                if viewType == .grid {
                    PuzzleGridView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
                } else {
                    PuzzleListView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
                }
            }
        }
    }
    
    // MARK: - METHODS
    private func setImportExportDelete() async {
        let authorDescriptor = FetchDescriptor<Author>()
        authorCount = (try? context.fetchCount(authorDescriptor)) ?? 0
        let puzzleDescriptor = FetchDescriptor<Puzzle>()
        puzzleCount = (try? context.fetchCount(puzzleDescriptor)) ?? 0
        let bookDescriptor = FetchDescriptor<Book>()
        bookCount = (try? context.fetchCount(bookDescriptor)) ?? 0
        
        switch medium {
        case .author:
            isExportEnabled = authorCount > 0 ? true : false
        case .book:
            isExportEnabled = bookCount > 0 ? true : false
        case .puzzle:
            isExportEnabled = puzzleCount > 0 ? true : false
        }
        
        isImportEnabled = FileManager().fileExists(atPath: FileManager.docDirURL.appendingPathComponent("\(medium.saveName)").path) ? true : false
    }
    
    private func importData() async {
        switch medium {
        case .author:
            let myAuthors = FileManager.decode([Author].self, from: medium.saveName)
            myAuthors.forEach { author in
                context.insert(author)
            }
            ns.show(type: .info, title: "Authors Imported", message: "Authors and their books imported from your save files.", duration: 3.0)
            print("Authors imported: \(myAuthors.count)")
        case .book:
            let myBooks = FileManager.decode([Book].self, from: medium.saveName)
            myBooks.forEach { book in
                context.insert(book)
            }
            ns.show(type: .info, title: "Books Imported", message: "Books imported from your save files.", duration: 3.0)
            print("Books imported: \(myBooks.count)")
        case .puzzle:
            let myPuzzles = FileManager.decode([Puzzle].self, from: medium.saveName)
            myPuzzles.forEach { puzzle in
                context.insert(puzzle)
            }
            ns.show(type: .info, title: "Puzzle Imported", message: "Puzzles imported from your save files.", duration: 3.0)
            print("Puzzles imported: \(myPuzzles.count)")
        }
        await setImportExportDelete()
    }
    
    private func exportData() async {
        switch medium {
        case .author:
            let descriptor = FetchDescriptor<Author>()
            let authors = (try? context.fetch(descriptor)) ?? []
            FileManager.encodeAndSave(objects: authors, fileName: medium.saveName)
        case .book:
            let descriptor = FetchDescriptor<Book>()
            let books = (try? context.fetch(descriptor)) ?? []
            FileManager.encodeAndSave(objects: books, fileName: medium.saveName)
        case .puzzle:
            let descriptor = FetchDescriptor<Puzzle>()
            let puzzles = (try? context.fetch(descriptor)) ?? []
            FileManager.encodeAndSave(objects: puzzles, fileName: medium.saveName)
        }
        ns.show(type: .info, title: "\(medium.saveName) Exported", message: "\(medium.saveName.capitalized) exported successfully!", duration: 3.0)
        print("\(medium.saveName) exported!")
        await setImportExportDelete()
    }
    
    private func deleteExports() async {
        switch medium {
        case .author:
            isImportEnabled = FileManager().deleteDocument(named: medium.saveName) ? false : true
        case .book:
            isImportEnabled = FileManager().deleteDocument(named: medium.saveName) ? false : true
        case .puzzle:
            isImportEnabled = FileManager().deleteDocument(named: medium.saveName) ? false : true
        }
        ns.show(type: .warning, title: "Export Deleted", message: "The \(medium.saveName.capitalized) export file has been deleted from your save library", duration: 3.0)
        print("\(medium.saveName) deleted")
    }
    
    private func handleIncomingURL(_ url: URL) {
        guard let type = try? url.resourceValues(forKeys: [.contentTypeKey]).contentType else {
            ns.show(type: .error, title: BZError.badFileType.description, message: BZError.badFileType.message, duration: BZError.badFileType.duration)
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            ns.show(type: .error, title: BZError.badFileContents.description, message: BZError.badFileContents.message, duration: BZError.badFileContents.duration)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            if type.conforms(to: .author) {
                let received = try decoder.decode(Author.self, from: data)
                try insert(received)
            } else if type.conforms(to: .book) {
                let received = try decoder.decode(Book.self, from: data)
                try insert(received)
            } else if type.conforms(to: .puzzle) {
                let received = try decoder.decode(Puzzle.self, from: data)
                try insert(received)
            } else {
                ns.show(type: .error, title: BZError.unsupportedFileFormat.description, message: BZError.unsupportedFileFormat.message, duration: BZError.unsupportedFileFormat.duration)
            }
        } catch {
            ns.show(type: .error, title: BZError.failedToDecode.description, message: BZError.failedToDecode.message, duration: BZError.failedToDecode.duration)
        }
    }
    
    private func insert<T>(_ object: T) throws where T: PersistentModel {
        context.insert(object)
        try context.save()
    }
}

// MARK: - PREVIEW
#Preview {
    let preview = Preview(Author.self, Puzzle.self)
    let authors = Author.sampleAuthors
    let books = Book.sampleBooks
    let quotes = Quote.sampleQuotes
    let puzzles = Puzzle.samplePuzzles
    let categories = Category.sampleCategories
    
    preview.addSamples(authors)
    preview.addSamples(books)
    preview.addSamples(puzzles)
    preview.addSamples(categories)
    
    // Add Books to the Authors
    // Agatha Christie
    authors[0].books.append(contentsOf: books[0..<3])
    
    // Add Quotes to Book
    // Agatha Christie - Murder on the Orient Express
    authors[0].books[1].quotes.append(quotes[2])
    
    // Peter Benchley
    authors[1].books.append(contentsOf: books[3..<5])
    
    // Add Quotes to Book
    // Peter Benchley - Jaws
    authors[1].books[0].quotes.append(contentsOf: quotes[0..<2])
    
    // Add Category to the Puzzzles
    // Hi, Neightbor!
    puzzles[0].categories?.append(categories[1])
    
    // The Bird House
    puzzles[1].categories?.append(categories[3])
    
    return HomeView()
        .modelContainer(preview.container)
        .environment(NotificationService())
        .environment(OpenLibraryService())
        .preferredColorScheme(.dark)
}
