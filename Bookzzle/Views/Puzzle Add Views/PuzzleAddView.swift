//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import PhotosUI
import SwiftData
import SwiftUI

struct PuzzleAddView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(NotificationService.self) private var ns
    
    // MARK: - LOCAL STATE PROPERTIES
    @Query private var puzzles: [Puzzle]
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
    
    @State private var puzzlePictureData: Data?
    @State private var selectedPuzzlePicture: PhotosPickerItem?
    
    @State private var isShowingAddNewPuzzleCategoriesView: Bool = false
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
                    ImageSelector()
                    
                    Button("Add Puzzle") {
                        checkPuzzleData()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || author.isEmpty)
                    
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
            
            if ns.showNotification {
                if let notification = ns.currentNotification {
                    VStack {
                        Spacer()
                        NotificationView(notification: notification)
                    }
                }
            }
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
        .fullScreenCover(isPresented: $isShowingAddNewPuzzleCategoriesView) {
            AddNewPuzzleCategories(puzzleCategories: $categories)
        }
        .task(id: selectedPuzzlePicture) {
            if let data = try? await selectedPuzzlePicture?.loadTransferable(type: Data.self) {
                puzzlePictureData = data
            }
        }
    }
    
    // MARK: - METHODS
    private func checkPuzzleData() {
        // Add Puzzle Button is disabled if Title or Author is empty so they don't need to be checked.
        // Add Puzzle will default to 1000 pieces, On Shelf, and Current Date for Date Added
        // Check to make sure BARCODE information is present
        if barcode.isEmpty {
            // Barcode is empty
            // If user is trying to add to the Wishlist, they probably don't have a barcode so this is ok.
            if status == Status.wishlist.rawValue {
                // Utilize a UUID for the barcode to ensure it is always unique.
                barcode = UUID().uuidString
                
                // Now check for duplicate puzzles by Title.
                if puzzles.contains(where: { $0.title.uppercased() == title.uppercased() }) {
                    // If a duplicate is found set a notification to let user know.
                    // Stop the process and clear the barcode field.
                    ns.show(type: .warning, title: BZNotification.puzzleDuplicate.description, message: BZNotification.puzzleDuplicate.message)
                    barcode = ""
                } else {
                    // No duplicate found, go ahead and add the puzzle to the database; no notification needed
                    insertPuzzle()
                }
            } else {
                // If not trying to add to Wishlist, then a barcode must be present.
                // If no barcode is included, set a notification that this is not allowed.
                ns.show(type: .error, title: BZNotification.missingBarcode.description, message: BZNotification.missingBarcode.message)
            }
        } else {
            // Barcode is not empty
            // Check for duplicate puzzles by Barcode
            // If one is found set a notifcation that this is not allowed.
            if puzzles.contains(where: { $0.barcode.uppercased() == barcode.uppercased() }) {
                // If a duplicate is found set an notifcation to let user know the puzzle won't be added.
                ns.show(type: .warning, title: BZNotification.puzzleDuplicate.description, message: BZNotification.puzzleDuplicate.message)
            } else {
                // No duplicate found, go ahead and add the puzzle to the database; no alert needed
                insertPuzzle()
            }
        }
    }
    
    private func insertPuzzle() {
        // Create a Puzzle Object with required information and insert it into the database.
        let newPuzzle = Puzzle(
            title: title,
            author: author,
            barcode: barcode,
            pieces: pieces,
            dateAdded: dateAdded,
            dateStarted: dateStarted,
            dateCompleted: dateCompleted,
            picture: puzzlePictureData,
            notes: notes,
            status: status,
            categories: categories.count < 1 ? nil : categories
        )
        context.insert(newPuzzle)
        try? context.save()
        
        // Set a notifcation to notify user that the puzzle has been added
        // Dismiss the screen after 3 seconds
        ns.show(type: .success, title: BZNotification.puzzleAdded(title: title).description, message: BZNotification.puzzleAdded(title: title).message, duration: BZNotification.puzzleAdded(title: title).duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            dismiss()
        }
    }
    
    // MARK: - EXTRACTED VIEWS
    private func backButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left.circle")
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(Circle())
        }
    }
    
    private func puzzleCategory(categories: [Category]) -> some View {
        VStack {
            Text("Categories")
                .detailInformationHeaderViewModifier()
            HStack {
                Button {
                    isShowingAddNewPuzzleCategoriesView.toggle()
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
    
    private func puzzleInformation() -> some View {
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
    
    private func puzzleStatistics() -> some View {
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
    
    private func puzzleNotes() -> some View {
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
    PuzzleAddView()
        .preferredColorScheme(.dark)
        .environment(NotificationService())
}
