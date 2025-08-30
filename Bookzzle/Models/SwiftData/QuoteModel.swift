//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation
import SwiftData

@Model
final class Quote: Codable {
    // MARK: - PROPERTIES
    var creationDate: Date
    var text: String
    var page: String
    
    var book: Book?
    
    // MARK: - INITIALIZER
    init(
        creationDate: Date = Date.now,
        text: String = "",
        page: String = "",
        book: Book? = nil
    ) {
        self.creationDate = creationDate
        self.text = text
        self.page = page
        self.book = book
    }
    
    // MARK: - REQUIRED FOR CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case creationDate, text, page
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        text = try container.decode(String.self, forKey: .text)
        page = try container.decode(String.self, forKey: .page)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(text, forKey: .text)
        try container.encode(page, forKey: .page)
    }
}
