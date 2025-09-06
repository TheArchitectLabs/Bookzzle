//
// Bookzzle
// 
// Created by The Architect on 9/1/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

// https://openlibrary.org/authors/OL23919A.json?fields=*

import Foundation

struct OLAuthor: Codable {
    let key: String
    let name: String
    let bio: OLBio?
    let birthDate: String?
    let deathDate: String?
    let remoteIDS: RemoteIDS?
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case bio
        case birthDate = "birth_date"
        case deathDate = "death_date"
        case remoteIDS = "remote_ids"
    }
}

struct OLBio: Codable {
    let type: String
    let value: String
}

struct RemoteIDS: Codable {
    let amazon: String?
    let librarything: String?
    let goodreads: String?
    let imdb: String?
    let wikidata: String?
}
