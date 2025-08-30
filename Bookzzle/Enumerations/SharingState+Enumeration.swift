//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum SharingState {
   
    // MARK: - PROPERTIES
    case idle
    case sharing
    case success(message: String)
    case failure(error: Error)
}
