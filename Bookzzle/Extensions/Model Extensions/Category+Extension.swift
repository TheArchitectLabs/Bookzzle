//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

extension Category {
    
    static var sampleCategories: [Category] {
        [
            Category(name: "Winter", color: "0000FF"),
            Category(name: "Spring", color: "00FF00"),
            Category(name: "Summer", color: "FF0000"),
            Category(name: "Fall", color: "FFFF00"),
        ]
    }
    
    // MARK: - COMPUTED PROPERTIES
    var hexColor: Color {
        Color(hex: self.color) ?? .green
    }
}
