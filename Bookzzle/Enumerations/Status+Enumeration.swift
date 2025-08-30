//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

enum Status: Int, CaseIterable, Identifiable {
    
    // MARK: - CASES
    case inprogress = 0
    case onshelf = 1
    case wishlist = 2
    case notreleased = 3
    case complete = 4
    
    // MARK: - REQUIRED FOR IDENTIFIABLE CONFORMANCE
    var id: Self {
        self
    }
    
    // MARK: - COMPUTED PROPERTIES
    var description: String {
        switch self {
        case .notreleased:
            "Not Released"
        case .wishlist:
            "Wishlist"
        case .onshelf:
            "On Shelf"
        case .inprogress:
            "In Progress"
        case .complete:
            "Complete"
        }
    }
    
    var icon: String {
        switch self {
        case .notreleased:
            "🫣"
        case .wishlist:
            "🤞"
        case .onshelf:
            "📚"
        case .inprogress:
            "📖"
        case .complete:
            "🏅"
        }
    }
    
    var color: Color {
        switch self {
        case .inprogress:
            return Color.green
        case .onshelf:
            return Color.orange
        case .wishlist, .notreleased:
            return Color.gray
        case .complete:
            return Color.red
        }
    }
}
