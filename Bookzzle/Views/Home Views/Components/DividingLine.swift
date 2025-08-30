//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct DividingLine: View {
    
    // MARK: - VIEW
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

// MARK: - PREVIEW
#Preview {
    DividingLine()
}
