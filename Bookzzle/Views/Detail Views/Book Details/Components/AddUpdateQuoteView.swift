//
//  AddUpdateQuoteView.swift
//  Bookzzle
//
//  Created by Michael on 8/21/25.
//

import SwiftUI

struct AddUpdateQuoteView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // MARK: - BINDING PROPERTIES
    @Bindable var book: Book
    @Binding var quoteToEdit: Quote?
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var quote: String = ""
    @State private var page: String = ""
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            Text("\(quoteToEdit == nil ? "Add" : "Update") Quote")
                .font(.title)
                .fontWeight(.heavy)
                .fontDesign(.rounded)
            
            TextEditor(text: $quote)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            LabeledContent {
                TextField("Page", text: $page)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
            } label: {
                Text("Page Number:")
            }
            
            HStack {
                Button("Cancel", role: .cancel) { dismiss() }
                Button("Submit") {
                    if let quoteToEdit {
                        quoteToEdit.text = quote
                        quoteToEdit.page = page
                        try? context.save()
                        dismiss()
                    } else {
                        let newQuote: Quote = Quote(text: quote, page: page)
                        book.quotes.append(newQuote)
                        try? context.save()
                        dismiss()
                    }
                }
                .disabled(quote.isEmpty)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            if let quoteToEdit {
                quote = quoteToEdit.text
                page = quoteToEdit.page
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
//  @Previewable @State var quoteToEdit: Quote? = Quote.sampleQuotes[0]         // Uncomment to show edit view
    @Previewable @State var quoteToEdit: Quote? = nil                           // Uncomment to show add view
    let book: Book = Book.sampleBooks[0]
    AddUpdateQuoteView(book: book, quoteToEdit: $quoteToEdit)
}
