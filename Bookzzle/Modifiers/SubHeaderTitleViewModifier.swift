//
//  SubHeaderTitleViewModifier.swift
//  Bookzzle
//
//  Created by Michael on 8/16/25.
//

import SwiftUI

struct SubHeaderTitleViewModifier: ViewModifier {
    
    // MARK: - VIEW MODIFIER
    func body(content: Content) -> some View {
        content
            .fontWeight(.black)
            .fontDesign(.rounded)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: - EXTENSION
extension View {
    func subHeaderTitleViewModifier() -> some View {
        modifier(SubHeaderTitleViewModifier())
    }
}
