//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct BackgroundImage: View {
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Image(.bookshelf)
                .resizable()
                .ignoresSafeArea()
                .opacity(0.9)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    BackgroundImage()
}
