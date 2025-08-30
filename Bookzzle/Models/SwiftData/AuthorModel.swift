//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

@Model
final class Author: Codable, Transferable {
    // MARK: - PROPERTIES
    var authorKey: String
    var authorName: String
    var authorBio: String
    var authorBirthDate: String
    var authorDeathDate: String
    var imdbID: String
    var goodReadsID: String
    var amazonID: String
    var libraryThingID: String
    
    var authorPhoto: Data?

    @Relationship(deleteRule: .cascade, inverse: \Book.author) var books: [Book] = []
    
    // MARK: - INITIALIZER
    init(
        authorKey: String,
        authorName: String,
        authorBio: String = "No bio available.",
        authorBirthDate: String = "N/A",
        authorDeathDate: String = "N/A",
        imdbID: String = "",
        goodReadsID: String = "",
        amazonID: String = "",
        libraryThingID: String = "",
        authorPhoto: Data? = nil,
        books: [Book] = []
    ) {
        self.authorKey = authorKey
        self.authorName = authorName
        self.authorBio = authorBio
        self.authorBirthDate = authorBirthDate
        self.authorDeathDate = authorDeathDate
        self.imdbID = imdbID
        self.goodReadsID = goodReadsID
        self.amazonID = amazonID
        self.libraryThingID = libraryThingID
        self.authorPhoto = authorPhoto
        self.books = books
    }
    
    // MARK: - REQUIRED FOR CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case authorKey
        case authorName
        case authorBio
        case authorBirthDate
        case authorDeathDate
        case imdbID
        case goodReadsID
        case amazonID
        case libraryThingID
        case authorPhoto
        case books
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authorKey = try container.decode(String.self, forKey: .authorKey)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.authorBio = try container.decode(String.self, forKey: .authorBio)
        self.authorBirthDate = try container.decode(String.self, forKey: .authorBirthDate)
        self.authorDeathDate = try container.decode(String.self, forKey: .authorDeathDate)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.goodReadsID = try container.decode(String.self, forKey: .goodReadsID)
        self.amazonID = try container.decode(String.self, forKey: .amazonID)
        self.libraryThingID = try container.decode(String.self, forKey: .libraryThingID)
        self.authorPhoto = try container.decodeIfPresent(Data.self, forKey: .authorPhoto)
        self.books = try container.decode([Book].self, forKey: .books)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authorName, forKey: .authorName)
        try container.encode(authorKey, forKey: .authorKey)
        try container.encode(authorBio, forKey: .authorBio)
        try container.encode(authorBirthDate, forKey: .authorBirthDate)
        try container.encode(authorDeathDate, forKey: .authorDeathDate)
        try container.encode(imdbID, forKey: .imdbID)
        try container.encode(goodReadsID, forKey: .goodReadsID)
        try container.encode(amazonID, forKey: .amazonID)
        try container.encode(libraryThingID, forKey: .libraryThingID)
        try container.encode(authorPhoto, forKey: .authorPhoto)
        try container.encode(books, forKey: .books)
    }
    
    // MARK: - REQUIRED FOR TRANSFERABLE CONFORMANCE
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .author)
    }
}

