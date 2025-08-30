//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct HeaderMenu: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("isAuthorSelected") private var isAuthorSelected: Bool = false
    @AppStorage("isBookSelected") private var isBookSelected: Bool = true
    @AppStorage("isPuzzleSelected") private var isPuzzleSelected: Bool = false
    @AppStorage("isShowingBookGrid") private var isShowingBookGrid: Bool = false
    @AppStorage("isShowingPuzzleGrid") private var isShowingPuzzleGrid: Bool = false
    @AppStorage("isShowingWishlistOnly") private var isShowingWishlistOnly: Bool = false
    @AppStorage("currentMedium") private var currentMedium: String = HomeMediumType.book.rawValue
    @AppStorage("currentViewType") private var currentViewType: String = HomeViewType.grid.rawValue
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var isImportEnabled: Bool = false
    @State private var isExportEnabled: Bool = false
    @State private var authorCount: Int = 0
    @State private var bookCount: Int = 0
    @State private var puzzleCount: Int = 0
    
    // MARK: - VIEW
    var body: some View {
        Menu {
            Section {
                Button("User Profile", systemImage: "person.fill") { }
            }
            Section {
                Button("Wishlist Only", systemImage: "exclamationmark.shield") {
                    isShowingWishlistOnly.toggle()
                }
                .tint(isShowingWishlistOnly ? .green : .primary)
            }
            Section {
                ControlGroup {
                    Button("Authors", systemImage: "applepencil.and.scribble") {
                        selectHomeMedium(.author)
                    }
                    .tint(isAuthorSelected ? .green : .primary)
                    Button("Books", systemImage: "books.vertical.fill") {
                        selectHomeMedium(.book)
                    }
                    .tint(isBookSelected ? .green : .primary)
                    Button("Puzzles", systemImage: "puzzlepiece.fill") {
                        selectHomeMedium(.puzzle)
                    }
                    .tint(isPuzzleSelected ? .green : .primary)
                }
            }
            Section {
                ControlGroup {
                    if !isAuthorSelected {
                        Button("Grid", systemImage: "square.grid.3x3") {
                            selectHomeViewType(.grid)
                        }
                        .tint(currentViewType == "grid" ? .green : .primary)
                    }
                    Button("List", systemImage: "list.bullet") {
                        selectHomeViewType(.list)
                    }
                    .tint(currentViewType == "list" ? .green : .primary)
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
        .task {
            selectHomeMedium(HomeMediumType(rawValue: currentMedium) ?? .book)
            await setImportExportDelete()
        }
        .onChange(of: currentMedium) { _, _ in
            Task {
                await setImportExportDelete()
            }
        }
    }
    
    // MARK: - METHODS
    private func selectHomeMedium(_ medium: HomeMediumType) {
        switch medium {
            case .book:
                isAuthorSelected = false
                isBookSelected = true
                isPuzzleSelected = false
                selectHomeViewType(isShowingBookGrid ? .grid : .list)
            case .puzzle:
                isAuthorSelected = false
                isBookSelected = false
                isPuzzleSelected = true
                selectHomeViewType(isShowingPuzzleGrid ? .grid : .list)
            default:
                isAuthorSelected = true
                isBookSelected = false
                isPuzzleSelected = false
                selectHomeViewType(.list)
        }
        
        currentMedium = medium.rawValue
    }
    
    private func selectHomeViewType(_ type: HomeViewType) {
        switch type {
            case .grid:
                if isBookSelected { isShowingBookGrid = true }
                if isPuzzleSelected { isShowingPuzzleGrid = true }
            case .list:
                if isBookSelected { isShowingBookGrid = false }
                if isPuzzleSelected { isShowingPuzzleGrid = false }
        }
        
        currentViewType = type.rawValue
    }
    
    private func setImportExportDelete() async {
        let authorDescriptor = FetchDescriptor<Author>()
        authorCount = (try? context.fetchCount(authorDescriptor)) ?? 0
        let puzzleDescriptor = FetchDescriptor<Puzzle>()
        puzzleCount = (try? context.fetchCount(puzzleDescriptor)) ?? 0
        let bookDescriptor = FetchDescriptor<Book>()
        bookCount = (try? context.fetchCount(bookDescriptor)) ?? 0
        
        switch currentMedium {
            case "book":
                isExportEnabled = bookCount > 0 ? true : false
            case "puzzle":
                isExportEnabled = puzzleCount > 0 ? true : false
            default:
                isExportEnabled = authorCount > 0 ? true : false
        }
        
        isImportEnabled = FileManager().fileExists(atPath: FileManager.docDirURL.appendingPathComponent("\(currentMedium)s.json").path) ? true : false
    }
    
    private func importData() async {
        switch currentMedium {
            case "book":
                let myBooks = FileManager.decode([Book].self, from: "books.json")
                myBooks.forEach { book in
                    context.insert(book)
                }
                print("Books imported: \(myBooks.count)")
            case "puzzle":
                let myPuzzles = FileManager.decode([Puzzle].self, from: "puzzles.json")
                myPuzzles.forEach { puzzle in
                    context.insert(puzzle)
                }
                print("Puzzles imported: \(myPuzzles.count)")
            default:
                let myAuthors = FileManager.decode([Author].self, from: "authors.json")
                myAuthors.forEach { author in
                    context.insert(author)
                }
                print("Authors imported: \(myAuthors.count)")
        }
        await setImportExportDelete()
    }
    
    private func exportData() async {
        switch currentMedium {
            case "book":
                let descriptor = FetchDescriptor<Book>()
                let books = (try? context.fetch(descriptor)) ?? []
                FileManager.encodeAndSave(objects: books, fileName: "books.json")
                print("Books exported: \(books)")
            case "puzzle":
                let descriptor = FetchDescriptor<Puzzle>()
                let puzzles = (try? context.fetch(descriptor)) ?? []
                FileManager.encodeAndSave(objects: puzzles, fileName: "puzzles.json")
                print("Puzzles exported: \(puzzles)")
            default:
                let descriptor = FetchDescriptor<Author>()
                let authors = (try? context.fetch(descriptor)) ?? []
                FileManager.encodeAndSave(objects: authors, fileName: "authors.json")
                print("Authors exported: \(authors)")
        }
        await setImportExportDelete()
    }
    
    private func deleteExports() async {
        switch currentMedium {
            case "book":
                isImportEnabled = FileManager().deleteDocument(named: "books.json") ? false : true
                print("Books.json deleted")
            case "puzzle":
                isImportEnabled = FileManager().deleteDocument(named: "puzzles.json") ? false : true
                print("Puzzles.json deleted")
            default:
                isImportEnabled = FileManager().deleteDocument(named: "authors.json") ? false : true
                print("Authors.json deleted")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    HeaderMenu()
}
