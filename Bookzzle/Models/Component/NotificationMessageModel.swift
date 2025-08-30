//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

struct NotificationMessage: Equatable, Identifiable {
    
    // MARK: - PROPERTIES
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let duration: Double
}
