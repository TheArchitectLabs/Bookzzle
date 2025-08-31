//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

struct OLWorksSearch: Codable {
    
    // MARK: - PROPERTIES
    let numFound: Int
    let start: Int
    let docs: [OLWorksDocs]
    
}

struct OLWorksDocs: Codable, Hashable {
    
    // MARK: - PROPERTIES
    let key: String
    let title: String
    var isbn: [String]?
    let firstSentence: [String]?
    let numberOfPagesMedian: Int?
    let firstPublishYear: Int?
    
    let authorKey: [String]?
    let authorName: [String]?
    
    var coverI: Int?
    let coverEditionKey: String?
    
}
