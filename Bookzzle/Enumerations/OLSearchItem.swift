//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum OLSearchItem: String, CaseIterable, Identifiable {
    case authors = "Authors"
    case books = "Books"

    var id: Self { self }

    var icon: String {
        switch self {
            case .authors: "person.circle.fill"
            case .books: "books.vertical.circle.fill"
        }
    }
}
