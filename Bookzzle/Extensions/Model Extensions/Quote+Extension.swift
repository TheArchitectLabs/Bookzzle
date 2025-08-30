//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

extension Quote {
    
    static var sampleQuotes: [Quote] {
        [
            Quote(
                creationDate: Date.now,
                text: "We're going to need a bigger boat!",
                page: "23",
                book: Book.sampleBooks[3]
            ),
            Quote(
                creationDate: Date.distantPast,
                text: "You go in the water, the cage goes in the water, the shark is in the water...our shark!",
                page: "2",
                book: Book.sampleBooks[3]
            ),
            Quote(
                creationDate: Date.now,
                text: "The little grey cells",
                page: "",
                book: Book.sampleBooks[1]
            )
        ]
    }
}
