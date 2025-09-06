//
// Bookzzle
// 
// Created by The Architect on 9/3/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct ITunesTestView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(OpenLibraryService.self) private var ols
    @Environment(NotificationService.self) private var ns
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var books: [ITResult] = []
    @State private var searchText: String = ""
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Search") {
                        Task {
                            await itunesSearch()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom)
                }
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
                if books.isEmpty {
                    Text("Nothing Returned")
                    Spacer()
                } else {
                    List(books, id: \.trackID) { book in
                        HStack {
                            let url = URL(string: book.artworkUrl60 ?? "")
                            AsyncImage(url: url)
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text(book.trackName ?? "No Name")
                                Text(book.artistName ?? "Missing")
                                HStack {
                                    Text("\(book.kind?.rawValue ?? "")")
                                    Spacer()
                                    Text("\(book.formattedPrice ?? "0") \(book.currency ?? Currency.usd)")
                                }
                            }
                            .lineLimit(1)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding(.horizontal, 5)
            
            if ns.showNotification {
                if let notification = ns.currentNotification {
                    VStack {
                        Spacer()
                        NotificationView(notification: notification)
                    }
                }
            }
        }
    }
    
    // MARK: - METHODS
    private func itunesSearch() async {
        do {
            let bookResults = try await ols.getAppleBook(term: searchText)
            books = bookResults.results
        } catch BZNotification.invalidURL {
            ns.show(
                type: .error,
                title: BZNotification.invalidURL.description,
                message: BZNotification.invalidURL.message,
                duration: BZNotification.invalidURL.duration
            )
        } catch BZNotification.invalidStatusCode(let statusCode) {
            ns.show(
                type: .error,
                title: BZNotification.invalidStatusCode(code: statusCode).description,
                message: BZNotification.invalidStatusCode(code: statusCode).message,
                duration: BZNotification.invalidStatusCode(code: statusCode).duration
            )
        } catch BZNotification.failedToDecode {
            ns.show(
                type: .error,
                title: BZNotification.failedToDecode.description,
                message: BZNotification.failedToDecode.message,
                duration: BZNotification.failedToDecode.duration
            )
        } catch BZNotification.invalidData {
            ns.show(
                type: .error,
                title: BZNotification.invalidData.description,
                message: BZNotification.invalidData.message,
                duration: BZNotification.invalidData.duration
            )
        } catch {
            ns.show(
                type: .error,
                title: BZNotification.unknown.description,
                message: BZNotification.unknown.message,
                duration: BZNotification.unknown.duration
            )
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ITunesTestView()
        .environment(OpenLibraryService())
        .environment(NotificationService())
        .preferredColorScheme(.dark)
}
