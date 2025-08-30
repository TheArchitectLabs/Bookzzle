//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct AuthorListView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - BINDINGS
    @Binding var isExportEnabled: Bool
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query(sort: \Author.authorName) private var authors: [Author]
    @State private var searchText: String = ""
    
    // MARK: - COMPUTED PROPERTIES
    var filteredAuthors: [Author] {
        if searchText.isEmpty {
            return authors
        } else {
            return authors.filter { $0.authorName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            HeaderSearchButtonAndTextField(searchText: $searchText)
                .padding(.bottom, 10)
            
            if filteredAuthors.isEmpty {
                ZStack {
                    Color.clear
                    ContentUnavailableView("No Authors Found", systemImage: HomeMediumType.author.icon, description: Text("Click the + button to add a new author to your collection!"))
                        .background(.ultraThinMaterial)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                        .offset(y: -50)
                }
            } else {
                List {
                    ForEach(filteredAuthors) { author in
                        NavigationLink(destination: AuthorDetailView(author: author)) {
                            authorListRowView(author: author)
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
            let author = authors[i]
            context.delete(author)
            ns.show(type: .warning, title: "Author Deleted", message: "\(author.authorName) has been deleted from your library", duration: 3.0)
        }
        if authors.count > 1 { isExportEnabled = false }
    }
    
    // MARK: - EXTRACTED VIEWS
    func authorListRowView(author: Author) -> some View {
        HStack {
            Image(uiImage: author.uAuthorPhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(author.authorName)
                    .font(.headline)
                Text(author.authorKey)
                Text("In My Library: \(author.books.count)")
            }
            .font(.subheadline)
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
    let preview = Preview(Author.self)
    let authors = Author.sampleAuthors
    
    authors[0].books.append(contentsOf: Book.sampleBooks[0..<3])
    authors[1].books.append(contentsOf: Book.sampleBooks[3..<5])
    
    preview.addSamples(authors)
    
    return NavigationStack {
        AuthorListView(isExportEnabled: $isExportEnabled)
            .modelContainer(preview.container)
            .environment(NotificationService())
            .preferredColorScheme(.dark)
    }
}
