//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct WorkListRow: View {
    
    // MARK: - LOCAL STATE PROPERTIES
    let work: OLWorksDocs
    
    // MARK: - VIEW
    var body: some View {
        HStack(spacing: 10) {
            workImage(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text(work.title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Text(work.uAuthorName)
                Text(work.key)
                Text("ISBN-10 (\(work.isbn?.count ?? 0)): \(work.isbn?.joined(separator: ", ") ?? "N/A")")
                Text("ISBN-13:")
                Text("First Sentence: \(work.firstSentence?.first ?? "")")
                Text("Number of Pages: \(work.numberOfPagesMedian ?? 0)")
                Text("First Publish Year: \(work.uFirstPublishYear)")
                Text("-------------------------")
                Text("CoverI: \(work.coverI ?? 0)")
                Text("Cover Edition Key: \(work.coverEditionKey ?? "N/A")")
                Text("-------------------------")
                Text("Author Key (\(work.authorKey?.count ?? 0)): \(work.authorKey?.joined(separator: ", ") ?? "N/A")")
                Text("Author Name (\(work.authorName?.count ?? 0)): \(work.authorName?.joined(separator: ", ") ?? "N/A")")
                
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
    func workImage(width: CGFloat, height: CGFloat) -> some View {
        CachedAsyncImage(
            url: URL(string: "https://covers.openlibrary.org/a/id/\(work.coverI ?? 0)-L.jpg?default=false"),
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
    let work: OLWorksDocs = OLWorksDocs.sample[0]
    
    WorkListRow(work: work)
        .environment(NotificationService())
        .environment(OpenLibraryService())
}
