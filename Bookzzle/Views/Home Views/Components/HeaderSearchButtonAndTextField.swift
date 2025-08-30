//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct HeaderSearchButtonAndTextField: View {
    
    // MARK: - PROPERTIES
    @Namespace private var namespace
    @State private var isSearchFieldVisible: Bool = false
    @Binding var searchText: String
    
    // MARK: - VIEW
    var body: some View {
        Group {
            if !isSearchFieldVisible {
                Label("Search", systemImage: "magnifyingglass")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                    .background(.green.gradient)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule().stroke(lineWidth: 2)
                    }
                    .onTapGesture {
                        withAnimation {
                            isSearchFieldVisible.toggle()
                        }
                    }
                    .matchedGeometryEffect(id: "change", in: namespace)
            } else {
                TextField("Search", text: $searchText, prompt: Text("Search"))
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 5)
                    .overlay(alignment: .trailing) {
                        Button {
                            withAnimation {
                                searchText = ""
                                isSearchFieldVisible.toggle()
                            }
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .font(.headline)
                                .background(.green)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                        }
                    }
                    .matchedGeometryEffect(id: "change", in: namespace)
            }
        }
        .animation(.smooth, value: isSearchFieldVisible)
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var searchText: String = ""
    
    HeaderSearchButtonAndTextField(searchText: $searchText)
            .preferredColorScheme(.dark)
}


