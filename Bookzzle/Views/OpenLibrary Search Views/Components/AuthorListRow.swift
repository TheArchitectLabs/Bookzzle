//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct AuthorListRow: View {
    
    // MARK: - LOCAL STATE PROPERTIES
    let author: OLAuthorDocs
    
    // MARK: - VIEW
    var body: some View {
        HStack(spacing: 10) {
            authorImage(width: 90, height: 90)
            
            VStack(alignment: .leading) {
                Text(author.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Text("OpenLibrary Key: \(author.key)")
                Text("Top Work: \(author.topWork ?? "Not Found")")
                Text("Work Count: \(author.workCount ?? 0)")
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
    func authorImage(width: CGFloat, height: CGFloat) -> some View {
        CachedAsyncImage(
            url: URL(string: "https://covers.openlibrary.org/a/olid/\(author.key)-L.jpg?default=false"),
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
    let author: OLAuthorDocs = OLAuthorDocs.sample[0]
    AuthorListRow(author: author)
}
