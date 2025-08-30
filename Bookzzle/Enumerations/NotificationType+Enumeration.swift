//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

enum NotificationType {
    
    // MARK: - PROPERTIES
    case success
    case error
    case warning
    case info
    
    // MARK: - COMPUTED PROPERTIES
    var color: Color {
        switch self {
            case .success:
                Color.green
            case .error:
                Color.red
            case .warning:
                Color.orange
            case .info:
                Color.blue
        }
    }
    
    var icon: String {
        switch self {
            case .success:
                "checkmark.circle.fill"
            case .error:
                "exclamationmark.triangle.fill"
            case .warning:
                "exclamationmark.circle.fill"
            case .info:
                "info.circle.fill"
        }
    }
}
