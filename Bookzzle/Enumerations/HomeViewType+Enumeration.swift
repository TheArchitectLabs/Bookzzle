//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum HomeViewType: String {
    
    // MARK: - PROPERTIES
    case grid
    case list
    
    // MARK: - COMPUTED PROPERTIES
    var icon: String {
        switch self {
        case .grid:
            "square.grid.3x3"
        case .list:
            "list.bullet"
        }
    }
}
