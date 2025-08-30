//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct PuzzleGridView: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("gridWidth") var gridWidth: Double = .zero
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - BINDINGS
    @Binding var isExportEnabled: Bool
    @Binding var isShowingWishlistOnly: Bool
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query(sort: \Puzzle.title) private var puzzles: [Puzzle]
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
        let columns = [GridItem(.adaptive(minimum: gridWidth))]
        
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
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredPuzzles) { puzzle in
                            NavigationLink(destination: PuzzleDetailView(puzzle: puzzle)) {
                                VStack {
                                    Image(uiImage: puzzle.uPuzzlePhoto)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: gridWidth, height: gridWidth)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text(puzzle.title)
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
    let preview = Preview(Puzzle.self)
    preview.addSamples(Puzzle.samplePuzzles)
    
    return NavigationStack {
        PuzzleGridView(isExportEnabled: $isExportEnabled, isShowingWishlistOnly: $isShowingWishlistOnly)
            .environment(NotificationService())
            .modelContainer(preview.container)
            .preferredColorScheme(.dark)
    }
}
