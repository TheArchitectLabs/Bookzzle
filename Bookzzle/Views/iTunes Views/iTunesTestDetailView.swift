//
// Bookzzle
// 
// Created by The Architect on 9/5/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI
import WebKit

struct iTunesTestDetailView: View {
    
    // MARK: - PROPERTIES
    let book: ITResult
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            Text(book.trackName ?? "Title Missing")
                .font(.system(size: 60))
                .fontWeight(.black)
                .fontDesign(.rounded)
                .lineLimit(1)
            
            let url = URL(string: book.artworkUrl100 ?? "")
            CachedAsyncImage(
                url: url,
                transaction: Transaction(animation: .bouncy(duration: 1))
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 200, height: 300)
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
                    .frame(width: 200, height: 200)
                @unknown default:
                    fatalError()
                }
            }
            
            Text(book.genres?.joined(separator: ", ") ?? "Genre Missing")
            Text(book.trackViewURL ?? "URL Missing")
            
//            if let description = book.description {
//                HTMLStringView(htmlContent: description)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
        }
        .padding(.horizontal, 5)
    }
}

// MARK: - PREVIEW
#Preview {
    let result = ITunesBook.sample
    let book = result.results[0]
    
    iTunesTestDetailView(book: book)
        .preferredColorScheme(.dark)
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
