//
//  SharingState+Enumeration.swift
//  Bookzzle
//
//  Created by Michael on 8/19/25.
//

import Foundation

enum SharingState {
   
    // MARK: - PROPERTIES
    case idle
    case sharing
    case success(message: String)
    case failure(error: Error)
}
