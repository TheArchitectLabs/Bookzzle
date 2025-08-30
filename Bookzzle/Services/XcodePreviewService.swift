//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation
import SwiftData

struct Preview {
    // MARK: - PROPERTIES
    let container: ModelContainer
    
    // MARK: - INITIALIZER
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create Xcode preview container")
        }
    }
    
    // MARK: - METHODS
    func addSamples(_ samples: [any PersistentModel]) {
        Task { @MainActor in
            samples.forEach { sample in
                container.mainContext.insert(sample)
            }
        }
    }
}
