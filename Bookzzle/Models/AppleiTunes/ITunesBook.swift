//
// Bookzzle
// 
// Created by The Architect on 9/3/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

// MARK: - OLAppleBook
struct ITunesBook: Codable {
    let resultCount: Int
    let results: [ITResult]
}

// MARK: - Result
struct ITResult: Codable {
    let artistIDS: [Int]?
    let formattedPrice: String?
    let trackViewURL: String?
    let trackCensoredName: String?
    let artistID: Int?
    let artistName: String?
    let genres: [String]?
    let price: Double?
    let releaseDate: Date?
    let trackName: String?
    
    let genreIDS: [String]?
    let artworkUrl60, artworkUrl100: String?
    let artistViewURL: String?
    let kind: Kind?
    let currency: Currency?
    let description: String?
    
    let trackID: Int?
    let userRatingCount: Int?
    let averageUserRating: Double?
    let fileSizeBytes: Int?

    enum CodingKeys: String, CodingKey {
        case artistIDS = "artistIds"
        case formattedPrice
        case trackViewURL = "trackViewUrl"
        case trackCensoredName
        case artistID = "artistId"
        case artistName
        case genres
        case price
        case releaseDate
        case trackName
        case genreIDS = "genreIds"
        case artworkUrl60, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case kind, currency, description
        case trackID = "trackId"
        case userRatingCount, averageUserRating, fileSizeBytes
    }
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case ebook = "ebook"
}
