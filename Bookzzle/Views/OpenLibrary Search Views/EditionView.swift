//
//  EditionView.swift
//  Bookzzle
//
//  Created by Michael on 8/26/25.
//

import SwiftUI

struct EditionView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(NotificationService.self) private var ns
    @Environment(OpenLibraryService.self) private var ols
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var entries: [OLEditionEntry] = []
    @State private var showMissingCovers: Bool = false
    let key: String
    
    var sortedEntries: [OLEditionEntry] {
        if showMissingCovers {
            entries.sorted { $0.uISBN13 > $1.uISBN13 }
        }  else {
            entries.filter { $0.uCovers > 0 }.sorted { $0.uISBN13 > $1.uISBN13 }
        }
    }
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                HeaderTitle()
                HStack(alignment: .center) {
                    backButton()
                    Text("Editions")
                        .subHeaderTitleViewModifier()
                    backButton().hidden()
                }
                .font(.title)
                .padding(.bottom, 15)
                
                Button("\(showMissingCovers ? "Hide" : "Show") Missing Covers", systemImage: showMissingCovers ? "checkmark.square" : "square") {
                    withAnimation {
                        showMissingCovers.toggle()
                    }
                }
                .foregroundStyle(.primary)
                .font(.headline)
                .background(.green.opacity(0.4))
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                List {
                    ForEach(sortedEntries) { entry in
                        EditionListRow(edition: entry)
                            .padding(.bottom, 5)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .task {
                    do {
                        entries = try await ols.fetchEdition(key: key, limit: 25, offset: 0)
                    } catch {
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - EXTRACTED VIEWS
    func backButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left.circle")
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(Circle())
        }
    }
}

// MARK: - PREVIEW
#Preview {
    let key: String = OLWorksDocs.sample[0].key
    
    EditionView(key: key)
        .environment(OpenLibraryService())
        .environment(NotificationService())
        .preferredColorScheme(.dark)
}
