//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct CoverSizeSlider: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("isSizeSliderShowing") var isSizeSliderShowing: Bool = true
    @AppStorage("gridWidth") var gridWidth: Double = .zero
    @AppStorage("frameWidth") var frameWidth: Double = .zero
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.horizontalSizeClass) private var hSize
    
    // MARK: - VIEW
    var body: some View {
        HStack {
            Group {
                if isSizeSliderShowing {
                    Slider(value: $gridWidth, in: 70...200, step: 5) {
                        Text("Cover Size")
                    } minimumValueLabel: {
                        Image(systemName: "circle.grid.3x3")
                            
                    } maximumValueLabel: {
                        Image(systemName: "circlebadge")
                    }
                    .foregroundStyle(.orange)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(Capsule().opacity(0.6))
                    .overlay(Capsule().stroke(.orange, lineWidth: 3))
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity
                                .animation(.easeInOut(duration: 1.0))
                            ),
                            removal: .move(edge: .trailing).combined(with: .opacity
                                .animation(.easeInOut(duration: 0.2))
                            )
                        )
                    )
                }
            }
            .animation(.default, value: isSizeSliderShowing)
            
            Spacer()
            
            Button {
                withAnimation { isSizeSliderShowing.toggle() }
            } label: {
                Image(systemName: "chevron.right")
                    .rotationEffect(isSizeSliderShowing ? .zero : .degrees(180))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .tint(isSizeSliderShowing ? .blue : .green)
            .overlay(Circle().stroke(lineWidth: 2))
        }
        .padding(.horizontal)
        .onAppear {
            if gridWidth == .zero {
                gridWidth = hSize == .compact ? 70 : 110
            }
            frameWidth = gridWidth * 1.666
        }
        .onChange(of: gridWidth) { _, _ in
            frameWidth = gridWidth * 1.666
        }
        .onChange(of: frameWidth) { _, _ in
            print("FrameWidth: \(frameWidth)")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    CoverSizeSlider()
}
