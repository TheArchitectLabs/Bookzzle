//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

struct OLEditionsSearch: Codable {
    
    // MARK: - PROPERTIES
    let entries: [OLEditionEntry]
    
}

struct OLEditionEntry: Codable, Identifiable {
    
    // MARK: - PROPERTIES
    let id: UUID = UUID()
    let key: String
    let title: String
    let covers: [Int]?
    let publishers: [String]?
    let isbn13: [String]?
    
    enum CodingKeys: CodingKey {
        case id
        case key
        case title
        case covers
        case publishers
        case isbn13
        
    }
    
    var uISBN13: String {
        if let isbn13 = isbn13?.first {
            return isbn13
        } else {
            return ""
        }
    }

    var uCovers: Int {
        if let covers = covers?.first {
            return covers
        } else {
            return 0
        }
    }
    
}
