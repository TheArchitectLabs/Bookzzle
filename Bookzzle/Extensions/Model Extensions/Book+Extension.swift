//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import UIKit

extension Book {
    
    // MARK: - PREVIEW SAMPLES
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.sampleBooks.forEach { book in
            container.mainContext.insert(book)
        }
        return container
    }
    
    static var sampleBooks: [Book] {
        [
            Book(
                key: "/works/OL471565W",
                title: "And Then There Were None",
                isbn13: "9780425129586",
                firstSentence: "In the corner of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times.",
                numberOfPages: 231,
                firstPublishYear: 1939,
                status: 0,
                coverPhoto: UIImage(named: "none")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL471576W",
                title: "Murder on the Orient Express",
                isbn13: "9784591089330",
                firstSentence: "It was five o'clock on a winter's morning in Syria.",
                numberOfPages: 240,
                firstPublishYear: 1933,
                status: 1,
                coverPhoto: UIImage(named: "orient")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL472049W",
                title: "Evil Under the Sun",
                isbn13: "9780008362812",
                firstSentence: "When Captain Roger Angmering built himself a house in the year 1782 on the island off Leathercombe Bay, it was thought the height of eccentricity on his part.",
                numberOfPages: 224,
                firstPublishYear: 1941,
                status: 2,
                coverPhoto: UIImage(named: "sun")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL3454854W",
                title: "Jaws",
                isbn13: "9788428603980",
                firstSentence: "",
                numberOfPages: 309,
                firstPublishYear: 1973,
                status: 4,
                coverPhoto: UIImage(named: "jaws")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[1]
            ),
            Book(
                key: "/works/OL3454855W",
                title: "Beast",
                isbn13: "9789022980194",
                firstSentence: "",
                numberOfPages: 368,
                firstPublishYear: 1991,
                status: 2,
                coverPhoto: UIImage(named: "beast")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[1]
            )
        ]
    }
    
    // MARK: - UNWRAPPED AND FORMATTED MODEL OPTIONALS FOR VIEWS
    public var uCoverPhoto: UIImage {
        if let data = coverPhoto, let photo = UIImage(data: data) {
            return photo
        } else {
            return UIImage(systemName: "books.vertical.fill")!
        }
    }
}
