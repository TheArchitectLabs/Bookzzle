//
//  DetailInformationBlockViewModifier.swift
//  Bookzzle
//
//  Created by Michael on 8/16/25.
//

import SwiftUI

struct DetailInformationBlockViewModifier: ViewModifier {
    
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
            }
    }
}

extension View {
    public func detailInformationBlockViewModifier(padding: CGFloat = 5) -> some View {
        modifier(DetailInformationBlockViewModifier(padding: padding))
    }
}
