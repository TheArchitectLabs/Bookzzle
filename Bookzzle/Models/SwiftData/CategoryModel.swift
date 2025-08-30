//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData

@Model
final class Category: Codable {
    // MARK: - PROPERTIES
    var name: String
    var color: String
    var puzzles: [Puzzle]?
    
    // MARK: - INITIALIZER
    init(
        name: String,
        color: String = "#00FF00",
        puzzles: [Puzzle]? = nil
    ) {
        self.name = name
        self.color = color
        self.puzzles = puzzles
    }
    
    // MARK: - REQUIRED FOR CODABLE CONFORMANCE
    enum CodingKeys: CodingKey {
        case name
        case color
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.color = try container.decode(String.self, forKey: .color)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
    }
}
