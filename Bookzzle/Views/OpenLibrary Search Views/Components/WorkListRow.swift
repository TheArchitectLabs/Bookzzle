//
//  BookSearchListRow.swift
//  Bookzzle
//
//  Created by Michael on 8/25/25.
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
                Text("Editions: \(work.uEditionCount)")
                Text("First Published: \(work.uFirstPublishYear)")
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
}
