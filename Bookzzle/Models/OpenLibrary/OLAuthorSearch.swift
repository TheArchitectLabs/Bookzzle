//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

struct OLAuthorSearch: Codable {
    
    // MARK: - PROPERTIES
    let numFound: Int
    let start: Int
    let docs: [OLAuthorDocs]
    
}

struct OLAuthorDocs: Codable {
    
    // MARK: - PROPERTIES
    let alternateNames: [String]?
    let birthDate: String?
    let deathDate: String?
    let key: String
    let name: String
    let topSubjects: [String]?
    let topWork: String?
    let workCount: Int?
    let ratingsAverage: Double?
    let ratingsCount: Int?
    let ratingsCount1: Int?
    let ratingsCount2: Int?
    let ratingsCount3: Int?
    let ratingsCount4: Int?
    let ratingsCount5: Int?
    
}
