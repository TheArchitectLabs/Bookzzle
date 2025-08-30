//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct DetailInformationHeaderViewModifier: ViewModifier {
    
    // MARK: - LOCAL STATE PROPERTIES
    let font: Font
    let bgColor: Color
    
    // MARK: - VIEW MODIFIER
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(.black)
            .fontDesign(.rounded)
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(bgColor.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - EXTENSION
extension View {
    public func detailInformationHeaderViewModifier(font: Font = .title2, bgColor: Color = .indigo) -> some View {
        modifier(DetailInformationHeaderViewModifier(font: font, bgColor: bgColor))
    }
}
