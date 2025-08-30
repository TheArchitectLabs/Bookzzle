//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum HomeMediumType: String {
    
    // MARK: - PROPERTIES
    case author
    case book
    case puzzle
    
    // MARK: - COMPUTED PROPERTIES
    var title: String {
        switch self {
            case .author:
                "My Authors"
            case .book:
                "My Books"
            case .puzzle:
                "My Puzzles"
        }
    }
    
    var icon: String {
        switch self {
        case .author:
            "applepencil.and.scribble"
        case .book:
            "books.vertical.fill"
        case .puzzle:
            "puzzlepiece.fill"
        }
    }
    
    var saveName: String {
        switch self {
        case .author:
            "authors.json"
        case .book:
            "books.json"
        case .puzzle:
            "puzzles.json"
        }
    }
}
