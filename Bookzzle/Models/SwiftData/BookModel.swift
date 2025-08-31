//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

@Model
final class Book: Codable, Transferable {
    // MARK: - PROPERTIES
    var key: String
    var title: String
    var isbn10: String
    var isbn13: String
    var firstSentence: String
    var numberOfPages: Int
    var firstPublishYear: Int
    var publisher: String
    var status: Int
    
    var coverPhoto: Data?
    
    var author: Author?
    
    @Relationship(deleteRule: .cascade, inverse: \Quote.book) var quotes: [Quote] = []
    
    // MARK: - INITIALIZER
    init (
        key: String,
        title: String,
        isbn10: String = "",
        isbn13: String = "",
        firstSentence: String = "",
        numberOfPages: Int = 0,
        firstPublishYear: Int = 0,
        publisher: String = "",
        status: Int = 2,
        coverPhoto: Data? = nil,
        quotes: [Quote] = [],
        author: Author? = nil
    ) {
        self.key = key
        self.title = title
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.firstSentence = firstSentence
        self.numberOfPages = numberOfPages
        self.firstPublishYear = firstPublishYear
        self.publisher = publisher
        self.status = status
        self.coverPhoto = coverPhoto
        self.quotes = quotes
        self.author = author
    }
    
    // MARK: - CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case key
        case title
        case isbn10
        case isbn13
        case firstSentence
        case numberOfPages
        case firstPublishYear
        case publisher
        case status
        case coverPhoto
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)
        self.isbn10 = try container.decode(String.self, forKey: .isbn10)
        self.isbn13 = try container.decode(String.self, forKey: .isbn13)
        self.firstSentence = try container.decode(String.self, forKey: .firstSentence)
        self.numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        self.firstPublishYear = try container.decode(Int.self, forKey: .firstPublishYear)
        self.publisher = try container.decode(String.self, forKey: .publisher)
        self.status = try container.decode(Int.self, forKey: .status)
        self.coverPhoto = try container.decodeIfPresent(Data.self, forKey: .coverPhoto)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(title, forKey: .title)
        try container.encode(isbn10, forKey: .isbn10)
        try container.encode(isbn13, forKey: .isbn13)
        try container.encode(firstSentence, forKey: .firstSentence)
        try container.encode(numberOfPages, forKey: .numberOfPages)
        try container.encode(firstPublishYear, forKey: .firstPublishYear)
        try container.encode(publisher, forKey: .publisher)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(coverPhoto, forKey: .coverPhoto)
    }
    
    // MARK: - REQUIRED FOR TRANSFERABLE CONFORMANCE
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .book)
    }
}
