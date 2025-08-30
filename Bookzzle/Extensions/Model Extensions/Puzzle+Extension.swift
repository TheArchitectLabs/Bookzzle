//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

extension Puzzle {
    
    // MARK: - PREVIEW SAMPLES
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Puzzle.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.samplePuzzles.forEach { puzzle in container.mainContext.insert(puzzle) }
        return container
    }
    
    static var samplePuzzles: [Puzzle] {
        [
            Puzzle(
                title: "Hi, Neighbor!",
                author: "Charles Wysocki",
                barcode: "079346115198",
                pieces: 1000,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "neighbor")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.onshelf.rawValue,
                categories: []
            ),

            Puzzle(
                title: "The Bird House",
                author: "Charles Wysocki",
                barcode: "079346114801",
                pieces: 1000,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "birdhouse")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.inprogress.rawValue
            ),
            
            Puzzle(
                title: "Prairie Wind Flowers",
                author: "Charles Wysocki",
                barcode: "079346114542",
                pieces: 1000,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "prariewinds")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.wishlist.rawValue
            ),
            
            Puzzle(
                title: "Burma Road",
                author: "Charles Wysocki",
                pieces: 1000,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "burma")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.complete.rawValue
            ),
            
            Puzzle(
                title: "Witch's Bay",
                author: "Charles Wysocki",
                barcode: "079346133093",
                pieces: 300,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "witchsbay")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.complete.rawValue
            ),
            
            Puzzle(
                title: "Confection Street",
                author: "Charles Wysocki",
                barcode: "079346124527",
                pieces: 2000,
                dateAdded: Date.now,
                dateStarted: Date.now.addingTimeInterval(1),
                dateCompleted: Date.now.addingTimeInterval(5),
                picture: UIImage(named: "confection")?.jpegData(compressionQuality: 1),
                notes: "",
                status: Status.complete.rawValue
            ),
            
            Puzzle(
                title: "At The Dog Park",
                author: "Ravensburger",
                barcode: "4005556823680",
                pieces: 1000,
                dateAdded: Date.now,
                dateStarted: nil,
                dateCompleted: nil,
                picture: nil,
                notes: "",
                status: 1,
                categories: []
            )
        ]
    }
    
    // MARK: - UNWRAPPED AND FORMATTED MODEL OPTIONALS FOR VIEWS
    public var uPuzzlePhoto: UIImage {
        if let data = picture, let photo = UIImage(data: data) {
            return photo
        } else {
            return UIImage(systemName: "puzzlepiece.fill")!
        }
    }
    
    public var uPuzzleAdded: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return (formatter.string(from: dateAdded))
    }
    
    public var uPuzzleStarted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if let dateStarted {
            return (formatter.string(from: dateStarted))
        } else {
            return ""
        }
    }
    
    public var uPuzzleCompleted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if let dateCompleted {
            return (formatter.string(from: dateCompleted))
        } else {
            return ""
        }
    }
}
