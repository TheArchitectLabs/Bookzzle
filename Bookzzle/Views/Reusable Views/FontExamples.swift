//
// Bookzzle
// 
// Created by The Architect on 8/23/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct FontExamples: View {
    
    // MARK: - PROPERTIES
    private let fontSizes: [(name: String, style: Font.TextStyle)] = [
        ("Large Title",   .largeTitle),
        ("Title",         .title),
        ("Title 2",       .title2),
        ("Title 3",       .title3),
        ("Headline",      .headline),
        ("Subheadline",   .subheadline),
        ("Body",          .body),
        ("Callout",       .callout),
        ("Footnote",      .footnote),
        ("Caption",       .caption),
        ("Caption 2",     .caption2),
    ]
    
    private let fontWeights: [(name: String, weight: Font.Weight)] = [
        ("UltraLight",      .ultraLight),
        ("Thin",            .thin),
        ("Light",           .light),
        ("Regular",         .regular),
        ("Medium",          .medium),
        ("Semibold",        .semibold),
        ("Bold",            .bold),
        ("Heavy",           .heavy),
        ("Black",           .black),
    ]
    
    private let fontDesigns: [(name: String, design: Font.Design)] = [
        ("Default",         .default),
        ("Rounded",         .rounded),
        ("Monospaced",      .monospaced),
    ]
    
    @State private var font: Int = 0
    @State private var weight: Int = 4
    @State private var design: Int = 0
    @State private var isUpperCased: Bool = false
    
    // MARK: - VIEW
    var body: some View {
        
        VStack {
            VStack(spacing: 10) {
                ForEach(fontSizes, id: \.name) { size in
                    Text(size.name)
                        .textCase(isUpperCased ? .uppercase : .lowercase)
                        .font(.system(size.style))
                        .fontWeight(fontWeights[weight].weight)
                        .fontDesign(fontDesigns[design].design)
                }
            }
            
            DividingLine()
                .padding(.top, 10)

            Toggle("Upper Case?", isOn: $isUpperCased)
            
            LabeledContent("Weights") {
                Picker("Weight", selection: $weight) {
                    ForEach(0..<fontWeights.count, id: \.self) { i in
                        Text(fontWeights[i].name).tag(i)
                    }
                }
            }
            
            LabeledContent("Designs") {
                Picker("Design", selection: $design) {
                    ForEach(0..<fontDesigns.count, id: \.self) { i in
                        Text(fontDesigns[i].name).tag(i)
                    }
                }
            }
            
            DividingLine()
                .padding(.bottom, 10)
            
            Text("This is a sample sentence using the selected settings.")
                .textCase(isUpperCased ? .uppercase : .none)
                .font(.system(fontSizes[font].style))
                .fontWeight(fontWeights[weight].weight)
                .fontDesign(fontDesigns[design].design)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - PREVIEW
#Preview("Font Examples") {
    FontExamples()
}
