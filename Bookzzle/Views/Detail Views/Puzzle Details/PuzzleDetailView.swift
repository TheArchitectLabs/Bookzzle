//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import PhotosUI
import SwiftUI

struct PuzzleDetailView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    // MARK: ENUMERATION FOR FOCUS STATE
    enum Field: Hashable {
        case title
        case author
        case barcode
        case notes
    }
    
    // MARK: - BINDING PROPERTIES
    @Bindable var puzzle: Puzzle
    
    // MARK: - LOCAL STATE PROPERTIES
    @FocusState private var focusedField: Field?
    
    @State private var puzzlePictureData: Data?
    @State private var selectedPuzzlePicture: PhotosPickerItem?
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
                        Text(puzzle.title)
                            .subHeaderTitleViewModifier()
                        shareButton()
                    }
                    .font(.title)
                    .padding(.bottom, 15)
                }
                
                VStack {
                    ImageSelector()
                    
                    ScrollView {
                        puzzleCategory(categories: puzzle.categories ?? [])
                        puzzleInformation(puzzle: puzzle)
                        puzzleStatistics(puzzle: puzzle)
                        puzzleNotes(notes: puzzle.notes)
                    }
                    .font(.callout)
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .onChange(of: puzzle.status) { oldValue, newValue in
            // Date started gets set when the puzzle is moved to "In Progress" Status = 0
            // Date completed gets reset because the puzzle has been started.
            if newValue == Status.inprogress.rawValue {
                puzzle.dateStarted = Date.now
                puzzle.dateCompleted = nil
            }
            
            // Date started and completed get reset if puzzle is moved to "On Shelf" Status = 1
            if newValue == Status.onshelf.rawValue && (oldValue == Status.inprogress.rawValue || oldValue == Status.complete.rawValue) {
                puzzle.dateStarted = nil
                puzzle.dateCompleted = nil
            }
            
            // Date started and completed get set to nil if puzzle is moved to "Wishlist" Status = 2
            // or "Not Released" Status = 3
            if newValue == Status.wishlist.rawValue || newValue == Status.notreleased.rawValue {
                puzzle.dateStarted = nil
                puzzle.dateCompleted = nil
            }
            
            // Date completed gets set when the puzzle is moved to "Complete" Status = 4
            if newValue == Status.complete.rawValue {
                if puzzle.dateStarted == nil { puzzle.dateStarted = Date.now }
                puzzle.dateCompleted = Date.now
            }
        }
        .fullScreenCover(isPresented: $isShowingCategoryAddUpdateView) {
            AddUpdateCategoryView(puzzle: puzzle)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        .task(id: selectedPuzzlePicture) {
            if let data = try? await selectedPuzzlePicture?.loadTransferable(type: Data.self) {
                puzzlePictureData = data
                puzzle.picture = data
            }
        }
        .onAppear {
            puzzlePictureData = puzzle.picture
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
    
    func shareButton() -> some View {
        ShareLink(
            item: puzzle,
            subject: Text("Bookzzle Puzzle"),
            message: Text("Check out this great puzzle!"),
            preview: SharePreview(
                "Share \"\(puzzle.title)\"",
                image: Image(uiImage: puzzle.uPuzzlePhoto)
            )
        ) {
            Image(systemName: "square.and.arrow.up.circle")
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
    
    func puzzleInformation(puzzle: Puzzle) -> some View {
        VStack(spacing: 3) {
            Text("Information")
                .detailInformationHeaderViewModifier()
            LabeledContent("Title:") {
                TextField("Title", text: $puzzle.title)
                    .focused($focusedField, equals: .title)
                    .frame(width: 200)
            }
            LabeledContent("Author:") {
                TextField("Author", text: $puzzle.author)
                    .focused($focusedField, equals: .author)
                    .frame(width: 200)
            }
            LabeledContent("Barcode:") {
                TextField("Barcode", text: $puzzle.barcode)
                    .focused($focusedField, equals: .barcode)
                    .frame(width: 200)
            }
            LabeledContent("Pieces:") {
                Picker("Pieces", selection: $puzzle.pieces) {
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
    
    func puzzleStatistics(puzzle: Puzzle) -> some View {
        VStack(spacing: 3) {
            Text("Statistics")
                .detailInformationHeaderViewModifier()
            LabeledContent("Status:") {
                Picker("Status", selection: $puzzle.status) {
                    ForEach(Status.allCases) { status in
                        Text(status.icon + status.description).tag(status.rawValue)
                    }
                }
            }
            .tint(.primary)

            DatePicker("Date Added", selection: $puzzle.dateAdded, displayedComponents: .date)

            LabeledContent {
                DatePicker(selection: Binding<Date>(get: { puzzle.dateStarted ?? Date() }, set: { puzzle.dateStarted = $0 }), displayedComponents: .date) { }
                    .opacity(puzzle.status == Status.inprogress.rawValue || puzzle.status == Status.complete.rawValue ? 1 : 0)
            } label: {
                Text("Date Started:")
            }
            
            LabeledContent {
                DatePicker(selection: Binding<Date>(get: { puzzle.dateCompleted ?? Date()}, set: { puzzle.dateCompleted = $0}), displayedComponents: .date) { }
                    .opacity( puzzle.status == Status.complete.rawValue ? 1 : 0)
            } label: {
                Text("Date Completed:")
            }
        }
        .detailInformationBlockViewModifier()
    }
    
    func puzzleNotes(notes: String) -> some View {
        VStack {
            Text("Notes")
                .detailInformationHeaderViewModifier()
            ScrollView {
                TextEditor(text: $puzzle.notes)
                    .focused($focusedField, equals: .notes)
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
    
    private func ImageSelector() -> some View {
        PhotosPicker(selection: $selectedPuzzlePicture, matching: .images, photoLibrary: .shared()) {
            Group {
                if let puzzlePictureData,
                   let uiImage = UIImage(data: puzzlePictureData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame([.horizontal], { size, axis in
                            size * 0.8
                        })
                } else {
                    Image(.burma)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame([.horizontal], { size, axis in
                            size * 0.8
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            VStack {
                                Text("Sample")
                                    .font(.title).bold()
                                Text("Click to Add Your Photo")
                                    .font(.headline)
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if puzzlePictureData != nil {
                Button(role: .destructive) {
                    selectedPuzzlePicture = nil
                    puzzlePictureData = nil
                    puzzle.picture = nil
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .white, radius: 4, x: 0, y: 0)
    }
}

// MARK: - PREVIEW
#Preview {
    let puzzle: Puzzle = Puzzle.samplePuzzles[0]
    let categories: [Category] = Category.sampleCategories
    
    puzzle.categories?.append(categories[0])
    puzzle.categories?.append(categories[1])
    
    return PuzzleDetailView(puzzle: puzzle)
        .preferredColorScheme(.dark)
}
