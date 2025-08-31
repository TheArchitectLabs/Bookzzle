//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct BookListView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - BINDINGS
    @Binding var isExportEnabled: Bool
    @Binding var isShowingWishlistOnly: Bool
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query(sort: \Book.title) private var books: [Book]
    @State private var searchText: String = ""
    
    // MARK: - COMPUTED PROPERTIES
    var filteredBooks: [Book] {
        if searchText.isEmpty && !isShowingWishlistOnly {
            return books
        } else if searchText.isEmpty && isShowingWishlistOnly {
            return books.filter { $0.status == Status.wishlist.rawValue }
        } else if !isShowingWishlistOnly {
            return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        } else {
            return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.status == Status.wishlist.rawValue }
        }
    }
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            HeaderSearchButtonAndTextField(searchText: $searchText)
                .padding(.bottom, 10)
            
            if filteredBooks.isEmpty {
                ZStack {
                    Color.clear
                    ContentUnavailableView("No Books Found", systemImage: HomeMediumType.book.icon, description: Text("Click the + button to add a new book to your library!"))
                        .background(.ultraThinMaterial)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                        .offset(y: -50)
                }
            } else {
                List {
                    ForEach(filteredBooks) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            bookListRowView(book: book)
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
            }
        }
    }
    
    // MARK: - METHODS
    func delete(_ indexSet: IndexSet) {
        for i in indexSet {
            let book = books[i]
            context.delete(book)
            ns.show(type: .warning, title: BZNotification.bookDeleted(title: book.title).description, message: BZNotification.bookDeleted(title: book.title).message)
        }
        if books.count > 1 { isExportEnabled = false }
    }
    
    // MARK: - EXTRACTED VIEWS
    private func bookListRowView(book: Book) -> some View {
        HStack {
            Image(uiImage: book.uCoverPhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 80)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .foregroundStyle(.primary)
                    .font(.headline)
                Text(book.author?.authorName ?? "")
                    .foregroundStyle(.secondary)
                HStack {
                    Spacer()
                    Text("\(Status(rawValue: book.status)?.description ?? "On Shelf")")
                        .frame(maxWidth: 100)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Status(rawValue: book.status)?.color ?? .green)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                }
            }
            .font(.subheadline)
            .padding(.horizontal, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.bottom, 5)
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var isExportEnabled: Bool = false
    @Previewable @State var isShowingWishlistOnly: Bool = false
    let preview = Preview(Book.self)
    preview.addSamples(Book.sampleBooks)
    
    return BookListView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
        .modelContainer(preview.container)
        .environment(NotificationService())
        .preferredColorScheme(.dark)
}
