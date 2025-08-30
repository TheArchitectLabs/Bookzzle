//
// Bookzzle
// 
// Created by The Architect on 8/29/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftData
import SwiftUI

struct AddNewPuzzleCategories: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // MARK: - BINDING PROPERTIES
    @Binding var puzzleCategories: [Category]
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query(sort: \Category.name) var categories: [Category]
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEditNameFocused: Bool
    @State private var showingAddCategoryView: Bool = false
    @State private var showingEditCategoryView: Bool = false
    @State private var name: String = ""
    @State private var color: Color = .red
    @State private var tempName: String = ""
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                backButton()
                Text("Categories")
                    .subHeaderTitleViewModifier()
                backButton().hidden()
            }
            .font(.title)
            .padding(.bottom, 15)
            
            ForEach(puzzleCategories) { cat in
                Text("\(cat.name)")
            }
            
            List {
                ForEach(categories) { category in
                    categoryListRow(category: category)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        if puzzleCategories.contains(categories[index]),
                           let puzzleCategoryIndex = puzzleCategories.firstIndex(where: {$0.id == categories[index].id }) {
                            puzzleCategories.remove(at: puzzleCategoryIndex)
                        }
                        context.delete(categories[index])
                        try? context.save()
                    }
                }
                
                createNewCategoryListRow()
                
                if showingAddCategoryView || showingEditCategoryView { addEditCategoryView() }
            }
            .listStyle(.plain)
            .font(.footnote)
        }
        .padding()
    }
    
    // MARK: - METHODS
    func addRemove(_ category: Category) {
        if puzzleCategories.isEmpty {
            puzzleCategories.append(category)
        } else {
            if puzzleCategories.contains(category), let index = puzzleCategories.firstIndex(where: { $0.id == category.id }) {
                puzzleCategories.remove(at: index)
            } else {
                puzzleCategories.append(category)
            }
        }
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
    
    func categoryListRow(category: Category) -> some View {
        HStack {
            if puzzleCategories.contains(category) {
                HStack {
                    Text("\(category.name) found")
                    Button {
                        addRemove(category)
                    } label: {
                        Image(systemName: puzzleCategories.contains(category) ? "circle.fill" : "circle")
                    }
                    .foregroundStyle(category.hexColor)
                }
            } else {
                HStack {
                    Text("\(category.name) missing")
                    Button {
                        addRemove(category)
                    } label: {
                        Image(systemName: "circle")
                    }
                    .foregroundStyle(category.hexColor)
                }
            }

            Text(category.name)
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                         tempName = category.name
                         name = category.name
                         color = Color(hex: category.color) ?? .clear
                         isNameFocused.toggle()
                         showingEditCategoryView.toggle()
                    } label: {
                        Label("Edit", systemImage: "slider.horizontal.2.square")
                    }
                    .tint(.orange)
                }
        }
        .listRowBackground(Color.clear)
    }
    
    func createNewCategoryListRow() -> some View {
        LabeledContent {
            Button {
                withAnimation {
                    name = ""
                    isNameFocused.toggle()
                    showingAddCategoryView.toggle()
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
            }
            .buttonStyle(.borderedProminent)
            .disabled(showingEditCategoryView || showingAddCategoryView)
        } label: {
            Text("Create new Category")
                .foregroundStyle(.secondary)
        }
        .listRowBackground(Color.clear)
    }
        
    func addEditCategoryView() -> some View {
        Group {
            Rectangle()
                .strokeBorder(style: StrokeStyle(dash: [10]))
                .frame(height: 1)
            
            TextField("name", text: $name)
                .focused($isNameFocused)
            
            ColorPicker("Set the category color", selection: $color, supportsOpacity: false)
            
            HStack {
                Button("Cancel") {
                    showingAddCategoryView ? showingAddCategoryView.toggle() : showingEditCategoryView.toggle()
                }
                Button(showingAddCategoryView ? "Create" : "Update") {
                    if showingAddCategoryView {
                        let newCategory = Category(name: name.capitalized, color: color.toHexString()!)
                        withAnimation {
                            context.insert(newCategory)
                            try? context.save()
                            showingAddCategoryView.toggle()
                        }
                    } else {
                        categories.forEach { category in
                            if tempName == category.name {
                                category.name = self.name
                                category.color = self.color.toHexString()!
                                try? context.save()
                                showingEditCategoryView.toggle()
                            }
                        }
                    }
                }
                .disabled(name.isEmpty)
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .listRowBackground(Color.clear)
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var puzzleCategories: [Category] = Category.sampleCategories
    let preview = Preview(Category.self)
    let categories = Category.sampleCategories
    preview.addSamples(categories)
    
    return AddNewPuzzleCategories(puzzleCategories: $puzzleCategories)
        .preferredColorScheme(.dark)
        .modelContainer(preview.container)
}
