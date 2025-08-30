//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct OpenLibrarySearchView: View {
    
    // MARK: - APP STORAGE (PERSISTENT) PROPERTIES
    @AppStorage("currentMedium") private var currentMedium: String = HomeMediumType.book.rawValue
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(NotificationService.self) private var ns
    @Environment(OpenLibraryService.self) private var ols
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var xOffset = 0.0
    @State private var isDisclosureExpanded: Bool = true
    @State private var olSearchItem: OLSearchItem = .books
    
    @State private var isbn: String = ""
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var subject: String = ""
    @State private var place: String = ""
    @State private var person: String = ""
    @State private var publisher: String = ""
    
    @State private var isSearching: Bool = false
    @State private var works: [OLWorksDocs] = []
    @State private var authors: [OLAuthorDocs] = []
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                HeaderTitle()
                HStack(alignment: .center) {
                    backButton()
                    Text("Search")
                        .subHeaderTitleViewModifier()
                    backButton().hidden()
                }
                .font(.title)
                .padding(.bottom, 15)
            
                disclosureBox()
                    .detailInformationBlockViewModifier()
                
                if isSearching {
                    searchingIndicator()
                } else {
                    if olSearchItem == .books {
                        List {
                            ForEach(works, id: \.key) { work in
                                if work.editionCount ?? 0 > 1 {
                                    NavigationLink(destination: EditionView(key: work.key)) {
                                        WorkListRow(work: work)
                                            .padding(.bottom, 5)
                                    }
                                } else {
                                    WorkListRow(work: work)
                                        .padding(.bottom, 5)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    } else {
                        List {
                            ForEach(authors, id: \.key) { author in
                                if author.workCount ?? 0 > 0 {
                                    AuthorListRow(author: author)
                                        .padding(.bottom, 5)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 5)
            .scrollIndicators(.hidden)
            
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
        .onAppear {
            olSearchItem = OLSearchItem(rawValue: currentMedium) ?? .books
        }
        .onChange(of: olSearchItem) { _, _ in
            clear()
        }
    }
    
    // MARK: - METHODS
    private func setQueryString() -> String {
        var searchString: String = ""

        if !title.isEmpty { searchString = "title=\"\(title.replacingOccurrences(of: " ", with: "+"))\"" }

        if !author.isEmpty && searchString.isEmpty {
            searchString = searchString + "author=\"\(author.replacingOccurrences(of: " ", with: "+"))\""
        } else if !author.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&author=\"\(author.replacingOccurrences(of: " ", with: "+"))\""
        }

        if !isbn.isEmpty && searchString.isEmpty {
            searchString = searchString + "isbn=\(isbn.replacingOccurrences(of: " ", with: "+"))"
        } else if !isbn.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&isbn=\(isbn.replacingOccurrences(of: " ", with: "+"))"
        }

        if !subject.isEmpty && searchString.isEmpty {
            searchString = searchString + "subject=\(subject.replacingOccurrences(of: " ", with: "+"))"
        } else if !subject.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&subject=\(subject.replacingOccurrences(of: " ", with: "+"))"
        }

        if !place.isEmpty && searchString.isEmpty {
            searchString = searchString + "place=\(place.replacingOccurrences(of: " ", with: "+"))"
        } else if !place.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&place=\(place.replacingOccurrences(of: " ", with: "+"))"
        }

        if !person.isEmpty && searchString.isEmpty {
            searchString = searchString + "person=\(person.replacingOccurrences(of: " ", with: "+"))"
        } else if !person.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&person=\(person.replacingOccurrences(of: " ", with: "+"))"
        }

        if !publisher.isEmpty && searchString.isEmpty {
            searchString = searchString + "publisher=\(publisher.replacingOccurrences(of: " ", with: "+"))"
        } else if !publisher.isEmpty && !searchString.isEmpty {
            searchString = searchString + "&publisher=\(publisher.replacingOccurrences(of: " ", with: "+"))"
        }

        print("Search String is: \(searchString)")

        return searchString
    }
    
    private func getWorksResults() {
        Task {
            do {
                isDisclosureExpanded = false
                isSearching = true
                let results = try await ols.fetchWork(query: setQueryString(), page: 1)
                if results.docs.count < 1 {
                    ns.show(
                        type: .warning,
                        title: BZError.noResults.description,
                        message: BZError.noResults.message,
                        duration: BZError.noResults.duration
                    )
                    clear()
                } else {
                    works = results.docs
                }
                isSearching = false
            } catch BZError.invalidURL {
                ns.show(
                    type: .error,
                    title: BZError.invalidURL.description,
                    message: BZError.invalidURL.message,
                    duration: BZError.invalidURL.duration
                )
            } catch BZError.invalidStatusCode(let statusCode) {
                ns.show(
                    type: .error,
                    title: BZError.invalidStatusCode(code: statusCode).description,
                    message: BZError.invalidStatusCode(code: statusCode).message,
                    duration: BZError.invalidStatusCode(code: statusCode).duration
                )
            } catch BZError.failedToDecode {
                ns.show(
                    type: .error,
                    title: BZError.failedToDecode.description,
                    message: BZError.failedToDecode.message,
                    duration: BZError.failedToDecode.duration
                )
            } catch BZError.invalidData {
                ns.show(
                    type: .error,
                    title: BZError.invalidData.description,
                    message: BZError.invalidData.message,
                    duration: BZError.invalidData.duration
                )
            } catch {
                ns.show(
                    type: .error,
                    title: BZError.unknown.description,
                    message: BZError.unknown.message,
                    duration: BZError.unknown.duration
                )
            }
        }
    }
    
    private func getAuthorResults() {
        Task {
            do {
                isDisclosureExpanded = false
                isSearching = true
                let results: OLAuthorSearch = try await ols.fetchAuthor(query: author)
                if results.docs.count < 1 {
                    ns.show(
                        type: .warning,
                        title: BZError.noResults.description,
                        message: BZError.noResults.message,
                        duration: BZError.noResults.duration
                    )
                    clear()
                } else {
                    authors = results.docs
                }
                isSearching = false
            } catch BZError.invalidURL {
                ns.show(
                    type: .error,
                    title: BZError.invalidURL.description,
                    message: BZError.invalidURL.message,
                    duration: BZError.invalidURL.duration
                )
            } catch BZError.invalidStatusCode(let statusCode) {
                ns.show(
                    type: .error,
                    title: BZError.invalidStatusCode(code: statusCode).description,
                    message: BZError.invalidStatusCode(code: statusCode).message,
                    duration: BZError.invalidStatusCode(code: statusCode).duration
                )
            } catch BZError.failedToDecode {
                ns.show(
                    type: .error,
                    title: BZError.failedToDecode.description,
                    message: BZError.failedToDecode.message,
                    duration: BZError.failedToDecode.duration
                )
            } catch BZError.invalidData {
                ns.show(
                    type: .error,
                    title: BZError.invalidData.description,
                    message: BZError.invalidData.message,
                    duration: BZError.invalidData.duration
                )
            } catch {
                ns.show(
                    type: .error,
                    title: BZError.unknown.description,
                    message: BZError.unknown.message,
                    duration: BZError.unknown.duration
                )
            }
        }
    }
    
    private func clear() {
        withAnimation {
            works.removeAll()
            authors.removeAll()
            isbn = ""
            title = ""
            author = ""
            subject = ""
            place = ""
            person = ""
            publisher = ""
            isDisclosureExpanded = true
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
    
    func disclosureBox() -> some View {
        GroupBox {
            DisclosureGroup(isExpanded: $isDisclosureExpanded) {
                VStack(spacing: 10) {
                    if olSearchItem == .books {
                        HStack {
                            TextField("ISBN", text: $isbn)
                            Button {
                                
                            } label: {
                                Image(systemName: "barcode.viewfinder")
                            }
                        }
                        HStack {
                            TextField("Title", text: $title)
                            TextField("Author", text: $author)
                        }
                        
                        HStack {
                            TextField("Subject", text: $subject)
                            TextField("Place", text: $place)
                        }
                        
                        HStack {
                            TextField("Person", text: $person)
                            TextField("Publisher", text: $publisher)
                        }
                    } else {
                        TextField("Author", text: $author)
                    }
                    
                    HStack {
                        Button("Search") {
                            if olSearchItem == .books {
                                withAnimation {
                                    isDisclosureExpanded = false
                                    getWorksResults()
                                }
                            } else {
                                withAnimation {
                                    isDisclosureExpanded = false
                                    getAuthorResults()
                                }
                            }
                        }
                        .disabled(isbn.isEmpty && title.isEmpty && author.isEmpty && subject.isEmpty && place.isEmpty && person.isEmpty && publisher.isEmpty)
                    }
                    .buttonStyle(.borderedProminent)
                }
            } label: {
                HStack {
                    Image(systemName: olSearchItem.icon)
                    Text("Query \(olSearchItem.rawValue)")
                }
            }
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
        } label: {
            HStack {
                Picker("Search For", selection: $olSearchItem) {
                    ForEach(OLSearchItem.allCases) { item in
                        Image(systemName: item.icon).tag(item)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 100, maxHeight: 30)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .shadow(color: .white, radius: 2, x: 0, y: 0)
                }
                Spacer()
                Image("openLibrary")
                    .resizable()
                    .frame(width: 100, height: 30)
                    .padding(5)
                    .background(.white.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(alignment: .topTrailing) {
                        Text("Powered By").font(.caption2).foregroundStyle(.black).offset(x: -8)
                    }
                Spacer()
                Button("Clear", role: .destructive) {
                    clear()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isbn.isEmpty && title.isEmpty && author.isEmpty && subject.isEmpty && place.isEmpty && person.isEmpty && publisher.isEmpty)
            }
        }
    }
    
    func searchingIndicator() -> some View {
        VStack {
            Spacer()
            Text("Searching...")
                .customAttribute(BlurredRainbowGradientAttribute())
                .font(.system(size: 30))
                .fontWeight(.black)
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .textRenderer(BlurredRainbowGradientRenderer(xOffset: xOffset))
            Spacer()
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
    NavigationStack {
        OpenLibrarySearchView()
            .environment(NotificationService())
            .environment(OpenLibraryService())
            .preferredColorScheme(.dark)
    }
}
