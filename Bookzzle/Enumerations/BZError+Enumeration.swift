//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum BZNotification: LocalizedError {
    // OpenLibrary Service Notifications
    case noNetworkAvailable
    case invalidURL
    case invalidStatusCode(code: Int)
    case failedToDecode
    case invalidData
    case noResults
    case unknown
    
    // Sharelink Received Data Notifications
    case badFileType
    case badFileContents
    case unsupportedFileFormat
    
    // Puzzle Notifications
    case puzzleAdded(title: String)
    case puzzleDuplicate
    case missingBarcode
    
    // Notification Message
    var message: String {
        switch self {
        case .noNetworkAvailable:
            "Unable to connect to the network. Please check your connection and try again."
        case .invalidURL:
            "The URL requested is invalid."
        case .invalidStatusCode(let code):
            "The server returned an invalid status code - (Status code: \(code)."
        case .failedToDecode:
            "We were unable to decode the data received."
        case .invalidData:
            "The data received was invalid."
        case .noResults:
            "Your query did not return any results. Please try a new search!"
        case .unknown:
            "An unknown error occurred."
        case .badFileType:
            "Unable to determine the file type. Import has been stopped"
        case .badFileContents:
            "Unable to read the file contents. Import has been stopped."
        case .unsupportedFileFormat:
            "This file is unsupported in Bookzzle."
        case .puzzleAdded(let title):
            "You have added \(title) to your library!"
        case .puzzleDuplicate:
            "This puzzle is already in your library."
        case .missingBarcode:
            "Puzzles require a barcode to add unless you are adding to your wishlist."
        }
    }

    // Notification Title
    var description: String {
        switch self {
        case .noNetworkAvailable: "No Network Available"
        case .invalidURL: "Invalid URL"
        case .invalidStatusCode: "Invalid Status Code"
        case .failedToDecode: "Failed to Decode"
        case .invalidData: "Invalid Data"
        case .noResults: "No Results Returned"
        case .unknown: "Unknow Error"
        case .badFileType: "Invalid File Type"
        case .badFileContents: "Invalid File Contents"
        case .unsupportedFileFormat: "Unsupported File"
        case .puzzleAdded: "Puzzle Added"
        case .puzzleDuplicate: "Duplicate Puzzle"
        case .missingBarcode: "Missing Barcode"
        }
    }
    
    var duration: Double {
        switch self {
        case .noNetworkAvailable: 3.0
        case .invalidURL: 3.0
        case .invalidStatusCode: 3.0
        case .failedToDecode: 3.0
        case .invalidData: 3.0
        case .noResults: 3.0
        case .unknown: 3.0
        case .badFileType: 3.0
        case .badFileContents: 3.0
        case .unsupportedFileFormat: 3.0
        case .puzzleAdded: 3.0
        case .puzzleDuplicate: 3.0
        case .missingBarcode: 3.0
        }
    }
}
