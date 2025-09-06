//
// Bookzzle
// 
// Created by The Architect on 9/5/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

extension ITunesBook {
    private static let isoFormatter: DateFormatter = {
        let f = DateFormatter()
        // Choose a format that matches the literal you have
        f.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()
    
    static var sample: ITunesBook {
        ITunesBook(
            resultCount: 60,
            results: [
                ITResult(
                    artistIDS: Optional([2065590]),
                    formattedPrice: Optional("$10.99"),
                    trackViewURL: Optional("https://books.apple.com/us/book/jaws/id543013720?uo=4"),
                    trackCensoredName: Optional("Jaws"),
                    artistID: Optional(2065590),
                    artistName: Optional("Peter Benchley"),
                    genres: Optional(["Mysteries & Thrillers", "Books", "Fiction & Literature", "Action & Adventure", "Horror"]),
                    price: Optional(10.99),
                    releaseDate: isoFormatter.date(from: "1981-07-01 07:00:00 +0000"),
                    trackName: Optional("Jaws"),
                    genreIDS: Optional(["9032", "38", "9031", "10039", "10048"]),
                    artworkUrl60: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication221/v4/92/4f/5d/924f5dd7-9b14-95a1-a40a-18a329397986/9780307828668.d.jpg/60x60bb.jpg"),
                    artworkUrl100: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication221/v4/92/4f/5d/924f5dd7-9b14-95a1-a40a-18a329397986/9780307828668.d.jpg/100x100bb.jpg"),
                    artistViewURL: Optional("https://books.apple.com/us/artist/peter-benchley/2065590?uo=4"),
                    kind: Optional(Bookzzle.Kind.ebook),
                    currency: Optional(Bookzzle.Currency.usd),
                    description: Optional("<b><i>NEW YORK TIMES</i> BESTSELLER • The shark-versus-man classic that inspired the blockbuster Steven Spielberg movie—now in a fiftieth anniversary edition with an exclusive foreword from the author’s wife, renowned ocean conservation advocate Wendy Benchley<br /><br />“A tightly written, tautly paced study of terror.”—<i>The Washington Post</i></b><br /><br />A great white shark terrorizes the beautiful summer getaway of Amity Island, and a motley group of men take to the water to do battle with the beast. A heart-pounding novel of suspense and a brilliant meditation on the nature of humanity, <i>Jaws</i> is one of the most iconic thrillers ever written.&#xa0;<br /><br />In addition to Wendy Benchley’s foreword, this edition features bonus content from Peter Benchley’s archives, including the manuscript’s original typed title page, a brainstorming list of possible titles, a letter from Benchley to film producer David Brown with candid feedback on the movie adaptation, and excerpts from Benchley’s book <i>Shark Trouble,</i> highlighting his firsthand account of writing <i>Jaws,</i> selling it to Universal Studios, and working with Steven Spielberg.<br /><br />After writing <i>Jaws</i> in the early 1970s, Peter Benchley was actively engaged with scientists and filmmakers, and over the ensuing decades, joined many expeditions around the world as they expanded their knowledge of sharks and shark behavior. He encouraged each new generation of <i>Jaws</i> fans to enjoy his riveting tale and to channel their excitement into support and protection of these magnificent prehistoric apex predators."),
                    trackID: Optional(543013720),
                    userRatingCount: Optional(486),
                    averageUserRating: Optional(4.0),
                    fileSizeBytes: nil
                ),
                ITResult(
                    artistIDS: Optional([2065590]),
                    formattedPrice: Optional("$4.99"),
                    trackViewURL: Optional("https://books.apple.com/us/book/the-girl-of-the-sea-of-cortez/id622179699?uo=4"),
                    trackCensoredName: Optional("The Girl of the Sea of Cortez"),
                    artistID: Optional(2065590),
                    artistName: Optional("Peter Benchley"),
                    genres: Optional(["Mysteries & Thrillers", "Books", "Fiction & Literature", "Action & Adventure"]),
                    price: Optional(4.99),
                    releaseDate: isoFormatter.date(from: "2013-08-20 07:00:00 +0000"),
                    trackName: Optional("The Girl of the Sea of Cortez"),
                    genreIDS: Optional(["9032", "38", "9031", "10039"]),
                    artworkUrl60: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication/v4/3c/b7/b1/3cb7b1cf-3624-581c-81ea-8bf124edfde7/9780345544155.jpg/60x60bb.jpg"),
                    artworkUrl100: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication/v4/3c/b7/b1/3cb7b1cf-3624-581c-81ea-8bf124edfde7/9780345544155.jpg/100x100bb.jpg"),
                    artistViewURL: Optional("https://books.apple.com/us/artist/peter-benchley/2065590?uo=4"),
                    kind: Optional(Bookzzle.Kind.ebook),
                    currency: Optional(Bookzzle.Currency.usd),
                    description: Optional("<b>Peter Benchley’s fascination with the sea and its magnificent inhabitants inspired such classic novels as <i>Jaws</i> and <i>The Deep</i>, making him the preeminent author of ocean adventure and suspense. <i>The</i> <i>Girl of the Sea of Cortez</i> was his most heartfelt, cherished story of the relationship between man and the sea, both those that live in it and those who love it.&#xa0; </b><br /> <b>&#xa0;</b><br /> On an island in the Gulf of California, an intrepid young woman named Paloma carries a special legacy from her father—a deep understanding of the sea and a sixth sense about the need to protect it.<br /> &#xa0;<br /> Every day, Paloma paddles her tiny boat into the ocean and anchors over a seamount—a submerged volcanic peak sixty feet underwater that is clustered with spectacular sea animals and a wondrous web of marine life.<br /> &#xa0;<br /> It is there that an astonishing event takes place, when on one of her dives Paloma is shadowed by a manta ray—an animal so large it blocks the sun. She develops an extraordinary relationship with this luminous, gentle creature, but instinctively knows its existence is a secret she must fiercely protect. <br /> &#xa0;<br />Benchley’s novel paints a poignant picture of humanity’s precarious relationship with the ocean, which unfolds alongside a heartrending story of familial bonds, often revealing that the ignorance of man is far more dangerous than the sea. Full of beauty, danger, and adventure, <i>The Girl of the Sea of Cortez</i> is triumphant—a novel to fall in love with.<br /> &#xa0;<br /> <b>Praise for <i>The Girl of the Sea of Cortez</i></b><br /> <b><i>&#xa0;</i></b><br /> “It’s hard not to compare Benchley’s tale . . . with Hemingway’s classic <i>The Old Man and the Sea</i>.”—<i>The Christian Science Monitor</i><br /> <b>&#xa0;</b><br /> “Charming.”—<i>The New York Times Book Review</i><br /> &#xa0;<br /> “For a hot summer’s day, <i>The Girl of the Sea of Cortez</i> is the next best thing to looking through a clear face mask into blue water swimming with fish.”—United Press International"),
                    trackID: Optional(622179699),
                    userRatingCount: Optional(23),
                    averageUserRating: Optional(4.5),
                    fileSizeBytes: nil
                ),
                ITResult(
                    artistIDS: Optional([2065590, 421586482]),
                    formattedPrice: Optional("$6.99"),
                    trackViewURL: Optional("https://books.apple.com/us/book/shark-life/id421586331?uo=4"),
                    trackCensoredName: Optional("Shark Life"),
                    artistID: Optional(2065590),
                    artistName: Optional("Peter Benchley & Karen Wojtyla"),
                    genres: Optional(["Animals for Kids", "Books", "Kids", "Science & Nature for Kids"]),
                    price: Optional(6.99),
                    releaseDate: isoFormatter.date(from: "2005-04-26 07:00:00 +0000"),
                    trackName: Optional("Shark Life"),
                    genreIDS: Optional(["11087", "38", "11086", "11160"]),
                    artworkUrl60: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication3/v4/0f/0b/10/0f0b101a-7950-4b52-a47e-1505479e657a/9780307545749.jpg/60x60bb.jpg"),
                    artworkUrl100: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication3/v4/0f/0b/10/0f0b101a-7950-4b52-a47e-1505479e657a/9780307545749.jpg/100x100bb.jpg"),
                    artistViewURL: Optional("https://books.apple.com/us/artist/peter-benchley-karen-wojtyla/2065590?uo=4"),
                    kind: Optional(Bookzzle.Kind.ebook),
                    currency: Optional(Bookzzle.Currency.usd),
                    description: Optional("<b>From the bestselling author of <i>Jaws</i> comes a firsthand guide to one of the most feared—and often misunderstood—animals: sharks!</b><br /><br /> In direct and accessible   prose, Peter Benchley&#xa0;sets the record straight about the many types of sharks (including the   ones that pose a genuine threat to us),  the behavior of sharks and other sea creatures   we fear, the odds against an attack, and how to improve them even further. He also   teaches us how to swim safely in the ocean by reading the tides and currents and   respecting all the inhabitants. Here are the lessons Peter has learned, the mistakes   he has made, the danger he has faced—and the spectacular sights he has seen in the   world’s largest environment. The book includes 16 pages of black-and-white photographs."),
                    trackID: Optional(421586331),
                    userRatingCount: Optional(31),
                    averageUserRating: Optional(4.0),
                    fileSizeBytes: nil
                ),
                ITResult(
                    artistIDS: Optional([324321708]),
                    formattedPrice: Optional("$19.99"),
                    trackViewURL: Optional("https://books.apple.com/us/book/sea-salt/id410045936?uo=4"),
                    trackCensoredName: Optional("Sea Salt"),
                    artistID: Optional(324321708),
                    artistName: Optional("Stan Waterman"),
                    genres: Optional(["Biographies & Memoirs", "Books"]),
                    price: Optional(19.99),
                    releaseDate: isoFormatter.date(from: "2005-12-14 08:00:00 +0000"),
                    trackName: Optional("Sea Salt"),
                    genreIDS: Optional(["9008", "38"]),
                    artworkUrl60: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication/30/21/05/mzi.hagwtosk.jpg/60x60bb.jpg"),
                    artworkUrl100: Optional("https://is1-ssl.mzstatic.com/image/thumb/Publication/30/21/05/mzi.hagwtosk.jpg/100x100bb.jpg"),
                    artistViewURL: Optional("https://books.apple.com/us/artist/stan-waterman/324321708?uo=4"),
                    kind: Optional(Bookzzle.Kind.ebook),
                    currency: Optional(Bookzzle.Currency.usd),
                    description: Optional("In 1965 National Geographic purchased rights to Stan Waterman\'s tropical odyssey with his family to Tahiti. A stellar string of ventures followed with his work on the 1968 shark classic Blue Water, White Death. A few years later he directed underwater photography for the film, The Deep followed by ten years of work with his friend Peter Benchley on ABC\'s American Sportsman - earning him five Emmys.<br />\nSea Salt is the handiwork of a born storyteller with a flair for language as stoked with imagery and insight as his films. Liberally sprinkled with humor, verve and singular turns of phrase, his autobiography and selected writings deftly portray the joys travails of a diving pioneer and legend. 287 pages including 71 photographs.&#xa0;"),
                    trackID: Optional(410045936),
                    userRatingCount: Optional(7),
                    averageUserRating: Optional(4.0),
                    fileSizeBytes: nil
                ),
            ]
        )
    }
}
