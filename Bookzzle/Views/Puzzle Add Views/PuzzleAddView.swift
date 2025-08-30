//
// Bookzzle
// 
// Created by The Architect on 8/29/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct PuzzleAddView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var barcode: String = ""
    @State private var pieces: Int = 1000
    @State private var status: Status.RawValue = Status.onshelf.rawValue
    @State private var dateAdded: Date = Date.now
    @State private var dateStarted: Date?
    @State private var dateCompleted: Date?
    @State private var notes: String = ""
    @State private var categories: [Category] = []
    
    @State private var isShowingCategoryAddUpdateView: Bool = false
    let numberOfPieces: [Int] = [100,300,500,1000,2000,0]
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                VStack(spacing: 0) {
                    HeaderTitle()
                    HStack(alignment: .center) {
                        backButton()
                        Text("Add Puzzle")
                            .subHeaderTitleViewModifier()
                        backButton().hidden()
                    }
                    .font(.title)
                    .padding(.bottom, 15)
                }
                
                VStack {
                    Image(systemName: "puzzlepiece")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                        .frame(maxWidth: 400)
                    
                    ScrollView {
                        puzzleCategory(categories: categories)
                        puzzleInformation()
                        puzzleStatistics()
                        puzzleNotes()
                    }
                    .font(.callout)
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .onChange(of: status) { oldValue, newValue in
            // Date started gets set when the puzzle is moved to "In Progress" Status = 0
            // Date completed gets reset because the puzzle has been started.
            if newValue == Status.inprogress.rawValue {
                dateStarted = Date.now
                dateCompleted = nil
            }
            
            // Date started and completed get reset if puzzle is moved to "On Shelf" Status = 1
            if newValue == Status.onshelf.rawValue && (oldValue == Status.inprogress.rawValue || oldValue == Status.complete.rawValue) {
                dateStarted = nil
                dateCompleted = nil
            }
            
            // Date started and completed get set to nil if puzzle is moved to "Wishlist" Status = 2
            // or "Not Released" Status = 3
            if newValue == Status.wishlist.rawValue || newValue == Status.notreleased.rawValue {
                dateStarted = nil
                dateCompleted = nil
            }
            
            // Date completed gets set when the puzzle is moved to "Complete" Status = 4
            if newValue == Status.complete.rawValue {
                if dateStarted == nil { dateStarted = Date.now }
                dateCompleted = Date.now
            }
        }
//        .fullScreenCover(isPresented: $isShowingCategoryAddUpdateView) {
//            AddUpdateCategoryView(puzzle: puzzle)
//        }
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
    
    func puzzleCategory(categories: [Category]) -> some View {
        VStack {
            Text("Categories")
                .detailInformationHeaderViewModifier()
            HStack {
                Button {
                    isShowingCategoryAddUpdateView.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(categories.sorted(using: KeyPathComparator(\Category.name))) { category in
                            Text(category.name)
                                .foregroundStyle(.primary)
                                .shadow(color: .black.opacity(0.9), radius: 3, x: 0, y: 0)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(RoundedRectangle(cornerRadius: 8).fill(category.hexColor))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .detailInformationBlockViewModifier()
    }
    
    func puzzleInformation() -> some View {
        VStack(spacing: 3) {
            Text("Information")
                .detailInformationHeaderViewModifier()
            LabeledContent("Title:") {
                TextField("Title", text: $title)
                    .frame(width: 200)
            }
            LabeledContent("Author:") {
                TextField("Author", text: $author)
                    .frame(width: 200)
            }
            LabeledContent("Barcode:") {
                TextField("Barcode", text: $barcode)
                    .frame(width: 200)
            }
            LabeledContent("Pieces:") {
                Picker("Pieces", selection: $pieces) {
                    ForEach(numberOfPieces, id: \.self) { num in
                        Text(num == 0 ? "Other" : "\(num)").tag(num)
                    }
                }
                .tint(.primary)
            }
        }
        .detailInformationBlockViewModifier()
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.words)
    }
    
    func puzzleStatistics() -> some View {
        VStack(spacing: 3) {
            Text("Statistics")
                .detailInformationHeaderViewModifier()
            LabeledContent("Status:") {
                Picker("Status", selection: $status) {
                    ForEach(Status.allCases) { status in
                        Text(status.icon + status.description).tag(status.rawValue)
                    }
                }
            }
            .tint(.primary)

            DatePicker("Date Added", selection: $dateAdded, displayedComponents: .date)

            LabeledContent {
                DatePicker(selection: Binding<Date>(get: { dateStarted ?? Date() }, set: { dateStarted = $0 }), displayedComponents: .date) { }
                    .opacity(status == Status.inprogress.rawValue || status == Status.complete.rawValue ? 1 : 0)
            } label: {
                Text("Date Started:")
            }
            
            LabeledContent {
                DatePicker(selection: Binding<Date>(get: { dateCompleted ?? Date()}, set: { dateCompleted = $0}), displayedComponents: .date) { }
                    .opacity( status == Status.complete.rawValue ? 1 : 0)
            } label: {
                Text("Date Completed:")
            }
        }
        .detailInformationBlockViewModifier()
    }
    
    func puzzleNotes() -> some View {
        VStack {
            Text("Notes")
                .detailInformationHeaderViewModifier()
            ScrollView {
                TextEditor(text: $notes)
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            }
        }
        .detailInformationBlockViewModifier()
    }
}

// MARK: - PREVIEW
#Preview {
    PuzzleAddView()
        .preferredColorScheme(.dark)
}
