//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct PuzzleListView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - BINDINGS
    @Binding var isExportEnabled: Bool
    @Binding var isShowingWishlistOnly: Bool
    
    // MARK: - PROPERTIES
    @Query(sort: [SortDescriptor(\Puzzle.status), SortDescriptor(\Puzzle.title)]) private var puzzles: [Puzzle]
    @State private var searchText: String = ""
    
    // MARK: - COMPUTED PROPERTIES
    var filteredPuzzles: [Puzzle] {
        if searchText.isEmpty && !isShowingWishlistOnly {
            return puzzles
        } else if searchText.isEmpty && isShowingWishlistOnly {
            return puzzles.filter { $0.status == Status.wishlist.rawValue }
        } else if !isShowingWishlistOnly {
            return puzzles.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        } else {
            return puzzles.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.status == Status.wishlist.rawValue }
        }
    }
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            HeaderSearchButtonAndTextField(searchText: $searchText)
                .padding(.bottom, 10)
            
            if filteredPuzzles.isEmpty {
                ZStack {
                    Color.clear
                    ContentUnavailableView("No Puzzles Found", systemImage: HomeMediumType.puzzle.icon, description: Text("Click the + button to add a new puzzle to your library!"))
                        .background(.ultraThinMaterial)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                        .offset(y: -50)
                }
            } else {
                List {
                    ForEach(filteredPuzzles) { puzzle in
                        NavigationLink(destination: PuzzleDetailView(puzzle: puzzle)) {
                            puzzleListRowView(puzzle: puzzle)
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
            let puzzle = puzzles[i]
            context.delete(puzzle)
            ns.show(type: .warning, title: BZNotification.puzzleDeleted(title: puzzle.title).description, message: BZNotification.puzzleDeleted(title: puzzle.title).message)
        }
        if puzzles.count > 1 { isExportEnabled = false }
    }
    
    // MARK: - EXTRACTED VIEWS
    func puzzleListRowView(puzzle: Puzzle) -> some View {
        HStack {
            Image(uiImage: puzzle.uPuzzlePhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(puzzle.title)
                    .font(.headline)
                Text(puzzle.author)
                HStack {
                    Text("Pieces: \(puzzle.pieces)")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(.blue.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                    Text("\(Status(rawValue: puzzle.status)?.description ?? "On Shelf")")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Status(rawValue: puzzle.status)?.color ?? .green)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                }
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
    @Previewable @State var isShowingWishlistOnly: Bool = false
    let preview = Preview(Puzzle.self)
    preview.addSamples(Puzzle.samplePuzzles)
    
    return NavigationStack {
        PuzzleListView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
            .modelContainer(preview.container)
            .environment(NotificationService())
            .preferredColorScheme(.dark)
    }
}
