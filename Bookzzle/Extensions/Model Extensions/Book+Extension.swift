//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import UIKit

extension Book {
    
    // MARK: - PREVIEW SAMPLES
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.sampleBooks.forEach { book in
            container.mainContext.insert(book)
        }
        return container
    }
    
    static var sampleBooks: [Book] {
        [
            Book(
                key: "/works/OL471565W",
                title: "And Then There Were None",
                ddc: ["823.912", "823.9", "828.912"],
                isbn: "9780425129586",
                languages: ["jpn", "vie", "fre", "ger", "fin", "spa", "ita", "por", "hun", "dut"],
                firstSentence: ["In the corner of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times.", "IN THE CORNER of a first-class smoking carriage, Mr. Justice Wargrave, lately retired from the bench, puffed at a cigar and ran an interested eye through the political news in the Times."],
                numberOfPages: 231,
                editionCount: 185,
                editionKey: ["OL58698112M", "OL58558644M", "OL57899505M", "OL50453605M", "OL49808404M", "OL49279818M", "OL48108914M", "OL51007761M", "OL50567190M", "OL50564888M"],
                firstPublishYear: 1939,
                status: 0,
                coverPhoto: UIImage(named: "none")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL471576W",
                title: "Murder on the Orient Express",
                ddc: ["823.912", "448.6", "823.91", "823.52", "[Fic]", "823"],
                isbn: "9784591089330",
                lccn: ["34004677", "2006045984", "84072783", "2001554703", "41004915", "99035293", "35002187", "75325425"],
                languages: ["jpn", "vie", "fre", "heb", "ger", "spa", "ita", "hin", "por", "hun"],
                firstSentence: ["It was five o'clock on a winter's morning in Syria."],
                numberOfPages: 240,
                editionCount: 221,
                editionKey: ["OL56780812M", "OL56842241M", "OL56219994M", "OL56123489M", "OL56241667M", "OL55589312M", "OL55700695M", "OL55387407M", "OL55337995M", "OL55020267M"],
                firstPublishYear: 1933,
                status: 1,
                coverPhoto: UIImage(named: "orient")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL472049W",
                title: "Evil Under the Sun",
                ddc: ["823.912", "822.912"],
                isbn: "9780008362812",
                lccn: ["85004371", "2004572743", "81067343", "88011927", "2006045987", "41019716", "45005365"],
                languages: ["eng", "spa", "vie", "ger", "chi", "pol", "fin", "rus", "fre", "ita"],
                firstSentence: ["When Captain Roger Angmering built himself a house in the year 1782 on the island off Leathercombe Bay, it was thought the height of eccentricity on his part."],
                numberOfPages: 224,
                editionCount: 114,
                editionKey: ["OL48990772M", "OL48407326M", "OL32737597M", "OL47659716M", "OL47659718M", "OL47659719M", "OL47659717M", "OL51124627M", "OL47326588M", "OL47326589M"],
                firstPublishYear: 1941,
                status: 2,
                coverPhoto: UIImage(named: "sun")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[0]
            ),
            Book(
                key: "/works/OL3454854W",
                title: "Jaws",
                ddc: ["813.54"],
                isbn: "9788428603980",
                lccn: ["73080799", "2013363497", "2006272425", "2005046451"],
                languages: ["spa", "fre", "chi", "eng", "rus", "ger"],
                firstSentence: [],
                numberOfPages: 309,
                editionCount: 58,
                editionKey: ["OL50638587M", "OL47804073M", "OL43522804M", "OL45845853M", "OL45613546M", "OL43061579M", "OL47079853M", "OL43150062M", "OL43598598M", "OL46941106M"],
                firstPublishYear: 1973,
                status: 4,
                coverPhoto: UIImage(named: "jaws")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[1]
            ),
            Book(
                key: "/works/OL3454855W",
                title: "Beast",
                ddc: ["813.54", "813"],
                isbn: "9789022980194",
                lccn: ["97812884", "91046598", "91010579"],
                languages: ["fre", "rus", "eng", "dut"],
                firstSentence: [],
                numberOfPages: 368,
                editionCount: 23,
                editionKey: ["OL24877087M", "OL37757765M", "OL9610551M", "OL7679696M", "OL22633622M", "OL9545164M", "OL22362709M", "OL7681142M", "OL31922844M", "OL24504629M"],
                firstPublishYear: 1991,
                status: 2,
                coverPhoto: UIImage(named: "beast")?.jpegData(compressionQuality: 1.0),
                quotes: [],
                author: Author.sampleAuthors[1]
            )
        ]
    }
    
    // MARK: - UNWRAPPED AND FORMATTED MODEL OPTIONALS FOR VIEWS
    public var uCoverPhoto: UIImage {
        if let data = coverPhoto, let photo = UIImage(data: data) {
            return photo
        } else {
            return UIImage(systemName: "books.vertical.fill")!
        }
    }
}
