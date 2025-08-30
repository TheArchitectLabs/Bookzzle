//
// Bookzzle
//
// Created by The Architect on 8/14/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import UIKit

extension Author {
    
    // MARK: - PREVIEW SAMPLES
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Author.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.sampleAuthors.forEach { author in
            container.mainContext.insert(author)
        }
        return container
    }
    
    static var sampleAuthors: [Author] {
        [
            Author(
                authorKey: "OL27695A",
                authorName: "Agatha Christie",
                authorBio: "Agatha Mary Clarissa Miller was born in Torquay, Devon, in the United Kingdom, the daughter of a wealthy American stockbroker. Her father died when she was eleven years old. Her mother taught her at home, encouraging her to write at a very young age. At the age of 16, she went to Mrs. Dryden's finishing school in Paris to study singing and piano. In 1914, at age 24, she married Colonel Archibald Christie, an aviator in the Royal Flying Corps. While he went away to war, she worked as a nurse and wrote her first novel, The Mysterious Affair at Styles (1920), which wasn't published until four years later. When her husband came back from the war, they had a daughter. In 1928 she divorced her husband, who had been having an affair. In 1930, she married Sir Max Mallowan, an archaeologist and a Catholic. She was happy in the early years of her second marriage, and did not divorce her husband despite his many affairs. She travelled with her husband's job, and set several of her novels set in the Middle East. Most of her other novels were set in a fictionalized Devon, where she was born.\r\n\r\nAgatha Christie is credited with developing the \"cozy style\" of mystery, which became popular in, and ultimately defined, the Golden Age of fiction in England in the 1920s and '30s, an age of which she is considered to have been Queen. In all, she wrote over 66 novels, numerous short stories and screenplays, and a series of romantic novels using the pen name Mary Westmacott. She was the single most popular mystery writer of all time. In 1971 she was made a Dame Commander of the Order of the British Empire.",
                authorBirthDate: "15 September 1890",
                authorDeathDate: "12 January 1976",
                imdbID: "",
                goodReadsID: "123715",
                amazonID: "B000APENBC",
                libraryThingID: "ChristieAgatha",
                authorPhoto: UIImage(named: "agatha")?.jpegData(compressionQuality: 1.0),
            ),
            Author(
                authorKey: "OL575390A",
                authorName: "Peter Benchley",
                authorBio: "No Bio Found",
                authorBirthDate: "1940",
                authorDeathDate: "No Data Found",
                imdbID: "nm0001940",
                goodReadsID: "59542",
                amazonID: "",
                libraryThingID: "",
                authorPhoto: UIImage(named: "benchley")?.jpegData(compressionQuality: 1.0),
            )
        ]
    }
    
    // MARK: - UNWRAPPED AND FORMATTED MODEL OPTIONALS FOR VIEWS
    public var uAuthorPhoto: UIImage {
        if let data = authorPhoto, let photo = UIImage(data: data) {
            return photo
        } else {
            return UIImage(named: "agatha")!
//            return UIImage(systemName: "person.fill")!
        }
    }
}
