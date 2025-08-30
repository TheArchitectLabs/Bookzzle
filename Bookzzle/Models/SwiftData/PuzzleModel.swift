//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI
import UniformTypeIdentifiers

@Model
final class Puzzle: Codable, Transferable {
    // MARK: - PROPERTIES
    var title: String
    var author: String
    var barcode: String
    var pieces: Int
    var dateAdded: Date
    var dateStarted: Date?
    var dateCompleted: Date?
    var picture: Data?
    var notes: String
    var status: Int
    
    @Relationship(deleteRule: .nullify, inverse: \Category.puzzles) var categories: [Category]?
    
    // MARK: - INITIALIZER
    init(
        title: String,
        author: String,
        barcode: String = "",
        pieces: Int = 1000,
        dateAdded: Date = Date.now,
        dateStarted: Date? = nil,
        dateCompleted: Date? = nil,
        picture: Data? = nil,
        notes: String = "",
        status: Int = Status.onshelf.rawValue,
        categories: [Category]? = nil
    ) {
        self.title = title
        self.author = author
        self.barcode = barcode
        self.pieces = pieces
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.picture = picture
        self.notes = notes
        self.status = status
        self.categories = categories
    }
    
    // MARK: - REQUIRED FOR CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case title
        case author
        case barcode
        case pieces
        case dateAdded
        case dateStarted
        case dateCompleted
        case picture
        case notes
        case status
        case categories
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        barcode = try container.decode(String.self, forKey: .barcode)
        pieces = try container.decode(Int.self, forKey: .pieces)
        dateAdded = try container.decode(Date.self, forKey: .dateAdded)
        dateStarted = try container.decodeIfPresent(Date.self, forKey: .dateStarted)
        dateCompleted = try container.decodeIfPresent(Date.self, forKey: .dateCompleted)
        picture = try container.decodeIfPresent(Data.self, forKey: .picture)
        notes = try container.decode(String.self, forKey: .notes)
        status = try container.decode(Int.self, forKey: .status)
        categories = try container.decodeIfPresent([Category].self, forKey: .categories)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(author, forKey: .author)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(pieces, forKey: .pieces)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encodeIfPresent(dateStarted, forKey: .dateStarted)
        try container.encodeIfPresent(dateCompleted, forKey: .dateCompleted)
        try container.encodeIfPresent(picture, forKey: .picture)
        try container.encode(notes, forKey: .notes)
        try container.encode(status, forKey: .status)
        try container.encode(categories, forKey: .categories)
    }
    
    // MARK: - REQUIRED FOR TRANSFERABLE CONFORMANCE
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .puzzle)
    }
}

