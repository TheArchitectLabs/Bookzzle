//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct BlurredRainbowGradientAttribute: TextAttribute { }

struct BlurredRainbowGradientRenderer: TextRenderer {
    
    // MARK: - PROPERTIES
    var xOffset: Double

    // MARK: - COMPUTED PROPERTIES
    var animatableData: Double {
        get { xOffset }
        set { xOffset = newValue }
    }

    // MARK: - METHODS
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[BlurredRainbowGradientAttribute.self] != nil {
                    var copy = context

                    copy.addFilter(
                        .colorShader(
                            ShaderLibrary.rainbowGradient(
                                .float2(run.typographicBounds.rect.size),
                                .float(xOffset)
                            )
                        )
                    )

                    copy.addFilter(.blur(radius: 10))

                    copy.draw(run)
                    copy.draw(run)
                    context.draw(run)
                } else {
                    context.draw(run)
                }
            }
        }
    }
}

struct HeaderTitle: View {
    
    // MARK: - PROPERTIES
    @State private var xOffset = 0.0
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            Text("BOOKZZLE!!")
                .customAttribute(BlurredRainbowGradientAttribute())
                .font(.system(size: 40))
                .fontWeight(.black)
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .textRenderer(BlurredRainbowGradientRenderer(xOffset: xOffset))
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                xOffset = 1
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    HeaderTitle()
}
