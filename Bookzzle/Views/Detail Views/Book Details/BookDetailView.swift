//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct BookDetailView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var isShowingQuoteView: Bool = false
    @State private var selectedQuote: Quote?
    
    let book: Book
    var authorNames: String {
        var name = ""
        book.authors.forEach { author in
            if name.isEmpty {
                name = author.authorName
            } else {
                name = "\n\(author.authorName)"
            }
        }
        return name
    }
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                VStack(spacing: 0) {
                    HeaderTitle()
                    
                    HStack(alignment: .center) {
                        backButton()
                        Text(book.title)
                            .subHeaderTitleViewModifier()
                        shareButton()
                    }
                    .font(.title)
                    .padding(.bottom, 15)
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        VStack {
                            Text(authorNames)
                                .font(.title)
                                .fontDesign(.rounded)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                bookImage()
                                VStack {
                                    Spacer()
                                    bookVendors()
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .detailInformationBlockViewModifier()
                        
                        bookLibraryInfo()
                        bookQuotes()
                        Spacer()
                    }
                    .font(.footnote)
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .sheet(
            isPresented: $isShowingQuoteView,
            onDismiss: { selectedQuote = nil }
        ) {
            AddUpdateQuoteView(book: book, quoteToEdit: $selectedQuote)
                .presentationDetents([.height(250)])
        }
    }
    
    // MARK: - METHODS

    
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
            item: book,
            subject: Text("Bookzzle Book"),
            message: Text("Check out this great book!"),
            preview: SharePreview(
                "Share \"\(book.title)\"",
                image: Image(uiImage: book.uCoverPhoto)
            )
        ) {
            Image(systemName: "square.and.arrow.up.circle")
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(Circle())
        }
    }
    
    func bookImage() -> some View {
        VStack(spacing: 0) {
            Image(uiImage: book.uCoverPhoto)
                .imageModifier(width: 180, height: 250, bgcolor: .white.opacity(0.1))
                .padding(5)
            Text("First Published: \(String(describing: book.firstPublishYear))")
                .foregroundStyle(.secondary)
        }
    }
    
    func bookVendors() -> some View {
        VStack(spacing: 5) {
            Button {
                
            } label: {
                Image(.amazon).resizable().scaledToFit()
            }
            .frame(width: 115, height: 30)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            Button {
                
            } label: {
                Image(.goodReads).resizable().scaledToFit()
            }
            .frame(width: 115, height: 30)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            Button {
                
            } label: {
                Image(.imdb).resizable().scaledToFit()
            }
            .frame(width: 115, height: 30)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            Button {
                
            } label: {
                Image(.libraryThing).resizable().scaledToFit()
            }
            .frame(width: 115, height: 30)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            Button {
                
            } label: {
                Image(.openLibrary).resizable().scaledToFit()
            }
            .frame(width: 115, height: 30)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
        }
    }
    
    func bookLibraryInfo() -> some View {
        VStack {
            Text("Library Information")
                .detailInformationHeaderViewModifier()
            LabeledContent("OL Key:") { Text("\(book.key)") }
            LabeledContent("ISBN-10:") { Text(book.isbn10) }
            LabeledContent("ISBN-13:") { Text(book.isbn13) }
            LabeledContent("Pages:") { Text("\(book.numberOfPages)")  }
        }
        .detailInformationBlockViewModifier()
    }
    
    func bookFirstSentence() -> some View {
        VStack {
            Text("First Sentence")
                .detailInformationHeaderViewModifier()
            ScrollView {
                Text(book.firstSentence)
            }
        }
        .detailInformationBlockViewModifier()
    }
    
    func bookQuotes() -> some View {
        VStack {
            HStack {
                backButton().hidden()
                Spacer()
                Text("Favorite Quotes")
                Spacer()
                Button {
                    isShowingQuoteView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.white)
                        .background(.green)
                        .clipShape(Circle())
                }
            }
            .detailInformationHeaderViewModifier()
            
            if book.quotes.isEmpty {
                VStack {
                    Text("No favorite quotes found.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Click the + button to add your first favorite quote!")
                        .foregroundStyle(.secondary)
                }
                .frame(height: 150)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(book.quotes, id: \.self) { quote in
                            VStack {
                                Text("\"\(quote.text)\"")
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(4)
                                Spacer()
                            }
                            .padding(5)
                            .frame(height: 115)
                            .frame(maxWidth: 200, alignment: .leading)
                            .background(.blue.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(alignment: .bottom) {
                                HStack {
                                    Text("Page: \(quote.page)")
                                    
                                    Spacer()
                                    
                                    Button("Edit") {
                                        selectedQuote = quote
                                        isShowingQuoteView.toggle()
                                    }
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(.green)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(lineWidth: 1))
                                    
                                    Button() {
                                        selectedQuote = quote
                                        context.delete(selectedQuote!)
                                        try? context.save()
                                        selectedQuote = nil
                                    } label: {
                                        Image(systemName: "x.circle.fill")
                                    }
                                    .foregroundStyle(.white)
                                    .padding(5)
                                    .background(.red)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(lineWidth: 1))
                                }
                                .padding(5)
                            }
                        }
                    }
                }
            }
        }
        .detailInformationBlockViewModifier(padding: 10)
    }
}

// MARK: - PREVIEW
#Preview {
    let book = Book.sampleBooks[3]
    book.quotes.append(contentsOf: Quote.sampleQuotes[0..<2])
    
    return BookDetailView(book: book)
        .preferredColorScheme(.dark)
}
