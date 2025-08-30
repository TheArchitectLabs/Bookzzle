//
//  DetailInformationHeaderViewModifier.swift
//  Bookzzle
//
//  Created by Michael on 8/16/25.
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
