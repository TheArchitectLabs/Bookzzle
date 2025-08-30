//
// Bookzzle
// 
// Created by The Architect on 7/24/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

struct OLWorksSearch: Codable {
    
    // MARK: - PROPERTIES
    let numFound: Int
    let start: Int
    let docs: [OLWorksDocs]
    
}

struct OLWorksDocs: Codable {
    
    // MARK: - PROPERTIES
    let key: String
    let title: String
    let firstPublishYear: Int?
    let language: [String]?
    let firstSentence: [String]?
    let numberOfPagesMedian: Int?
    
    let authorKey: [String]?
    let authorName: [String]?
    
    var coverI: Int?
    let coverEditionKey: String?
    
    let ddc: [String]?
    let isbn: [String]?
    let lccn: [String]?
    
    let editionCount: Int?
    let editionKey: [String]?
    
}
