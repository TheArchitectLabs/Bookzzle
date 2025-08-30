//
//  BookzzleApp.swift
//  Bookzzle
//
//  Created by Michael on 8/30/25.
//

import SwiftUI

@main
struct BookzzleApp: App {
    
    // MARK: - ENVIRONMENT PROPERTIES
    
    // MARK: - LOCAL STATE PROPERTIES
    @State var notificationService = NotificationService()
    @State var openLibraryService = OpenLibraryService()
    
    // MARK: - SCENE
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [Author.self, Puzzle.self])
                .environment(notificationService)
                .environment(openLibraryService)
                .preferredColorScheme(.dark)
        }
    }
}
