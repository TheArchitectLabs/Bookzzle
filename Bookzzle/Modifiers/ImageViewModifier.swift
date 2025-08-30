//
// Bookzzle
// 
// Created by The Architect on 8/16/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

extension Image {
    // MARK: - MODIFIED IMAGE
    func imageModifier(width: CGFloat, height: CGFloat, bgcolor: Color = .clear) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
            .foregroundColor(.white)
            .background(bgcolor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .primary, radius: 2, x: 0, y: 0)
    }
}
