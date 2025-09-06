//
// Bookzzle
// 
// Created by The Architect on 9/2/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

extension OLAuthor {
    static var sample: OLAuthor {
        OLAuthor(
            key: "/authors/OL23919A",
            name: "J. K. Rowling",
            bio: OLBio(
                type: "/type/text", value: "Joanne \"Jo\" Murray, OBE (Rowling), better known under the pen name J. K. Rowling, is a British author best known as the creator of the Harry Potter fantasy series, the idea for which was conceived whilst on a train trip from Manchester to London in 1990. The Potter books have gained worldwide attention, won multiple awards, sold more than 400 million copies, and been the basis for a popular series of films."
            ),
            birthDate: "31 July 1965",
            deathDate: nil,
            remoteIDS: RemoteIDS(
                amazon: "B000AP9A6K",
                librarything: "rowlingjk",
                goodreads: "1077326",
                imdb: "nm0746830",
                wikidata: "Q34660"
            )
        )
    }
}
