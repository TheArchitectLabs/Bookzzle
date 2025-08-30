//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct BookGridView: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("gridWidth") var gridWidth: Double = .zero
    @AppStorage("frameWidth") var frameWidth: Double = .zero
    
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
        let columns = [GridItem(.adaptive(minimum: gridWidth))]
        
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
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredBooks) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                VStack {
                                    Image(uiImage: book.uCoverPhoto)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: frameWidth)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text(book.title)
                                        .lineLimit(1)
                                        .font(.caption)
                                }
                                .tint(.white)
                            }
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
                .overlay(alignment: .bottomTrailing) { CoverSizeSlider() }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var isExportEnabled: Bool = false
    @Previewable @State var isShowingWishlistOnly: Bool = false
    let preview = Preview(Book.self)
    preview.addSamples(Book.sampleBooks)
    
    return NavigationStack {BookGridView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
            .environment(NotificationService())
            .modelContainer(preview.container)
            .preferredColorScheme(.dark)
    }
}
