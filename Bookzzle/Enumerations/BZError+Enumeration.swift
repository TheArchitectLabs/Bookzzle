//
//  BZError+Enumeration.swift
//  Bookzzle
//
//  Created by Michael on 8/24/25.
//

import Foundation

enum BZError: LocalizedError {
    case noNetworkAvailable
    case invalidURL
    case invalidStatusCode(code: Int)
    case failedToDecode
    case invalidData
    case noResults
    case unknown
    case badFileType
    case badFileContents
    case unsupportedFileFormat

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
        }
    }

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
        }
    }
}
