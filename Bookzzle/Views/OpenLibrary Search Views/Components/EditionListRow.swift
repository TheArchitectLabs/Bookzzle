//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct EditionListRow: View {
    
    // MARK: - LOCAL STATE PROPERTIES
    let edition: OLEditionEntry
    
    // MARK: - VIEW
    var body: some View {
        HStack(spacing: 10) {
            editionImage(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text(edition.title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Text("Publisher: \(edition.publishers?.first ?? "Unknown")")
                Text("ISBN-10: \(edition.isbn10?.first ?? "Unknown")")
                Text("ISBN-13: \(edition.isbn13?.first ?? "Unknown")")
                Text("OL Key: \(edition.key)")
                
            }
            .lineLimit(1)
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    // MARK: - EXTRACTED VIEWS
    func editionImage(width: CGFloat, height: CGFloat) -> some View {
        CachedAsyncImage(
            url: URL(string: "https://covers.openlibrary.org/a/id/\(edition.covers?[0] ?? 0)-L.jpg?default=false"),
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
}

// MARK: - PREVIEW
#Preview {
    let edition: OLEditionEntry = OLEditionEntry.sample[0]
    EditionListRow(edition: edition)
        .environment(NotificationService())
        .environment(OpenLibraryService())
}
