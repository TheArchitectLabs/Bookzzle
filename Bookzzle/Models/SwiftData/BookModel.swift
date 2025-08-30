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
    var ddc: [String]
    var isbn: String
    var lccn: [String]
    var languages: [String]
    var firstSentence: [String]
    var numberOfPages: Int
    var editionCount: Int
    var editionKey: [String]
    var firstPublishYear: Int
    var status: Int
    
    var coverPhoto: Data?
    
    var author: Author?
    
    @Relationship(deleteRule: .cascade, inverse: \Quote.book) var quotes: [Quote] = []
    
    // MARK: - INITIALIZER
    init (
        key: String,
        title: String,
        ddc: [String] = [],
        isbn: String = "",
        lccn: [String] = [],
        languages: [String] = [],
        firstSentence: [String] = [],
        numberOfPages: Int = 0,
        editionCount: Int = 0,
        editionKey: [String] = [],
        firstPublishYear: Int = 0,
        status: Int = 2,
        coverPhoto: Data? = nil,
        quotes: [Quote] = [],
        author: Author? = nil
    ) {
        self.key = key
        self.title = title
        self.ddc = ddc
        self.isbn = isbn
        self.lccn = lccn
        self.languages = languages
        self.firstSentence = firstSentence
        self.numberOfPages = numberOfPages
        self.editionCount = editionCount
        self.editionKey = editionKey
        self.firstPublishYear = firstPublishYear
        self.status = status
        self.coverPhoto = coverPhoto
        self.quotes = quotes
        self.author = author
    }
    
    // MARK: - CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case key
        case title
        case ddc
        case isbn
        case lccn
        case languages
        case firstSentence
        case numberOfPages
        case editionCount
        case editionKey
        case firstPublishYear
        case status
        case coverPhoto
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)
        self.ddc = try container.decode([String].self, forKey: .ddc)
        self.isbn = try container.decode(String.self, forKey: .isbn)
        self.lccn = try container.decode([String].self, forKey: .lccn)
        self.languages = try container.decode([String].self, forKey: .languages)
        self.firstSentence = try container.decode([String].self, forKey: .firstSentence)
        self.numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        self.editionCount = try container.decode(Int.self, forKey: .editionCount)
        self.editionKey = try container.decode([String].self, forKey: .editionKey)
        self.firstPublishYear = try container.decode(Int.self, forKey: .firstPublishYear)
        self.status = try container.decode(Int.self, forKey: .status)
        self.coverPhoto = try container.decodeIfPresent(Data.self, forKey: .coverPhoto)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(title, forKey: .title)
        try container.encode(ddc, forKey: .ddc)
        try container.encode(isbn, forKey: .isbn)
        try container.encode(lccn, forKey: .lccn)
        try container.encode(languages, forKey: .languages)
        try container.encode(firstSentence, forKey: .firstSentence)
        try container.encode(numberOfPages, forKey: .numberOfPages)
        try container.encode(editionCount, forKey: .editionCount)
        try container.encode(editionKey, forKey: .editionKey)
        try container.encode(firstPublishYear, forKey: .firstPublishYear)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(coverPhoto, forKey: .coverPhoto)
    }
    
    // MARK: - REQUIRED FOR TRANSFERABLE CONFORMANCE
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .book)
    }
}
