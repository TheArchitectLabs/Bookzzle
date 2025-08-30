//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct AuthorDetailView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Namespace private var animation
    
    // MARK: - LOCAL STATE PROPERTIES
    @State private var isImageExpanded: Bool = false
    let author: Author
    
    // MARK: - VIEW
    var body: some View {
        ZStack {
            BackgroundImage()
            
            VStack {
                VStack(spacing: 0) {
                    HeaderTitle()
                    HStack(alignment: .center) {
                        backButton()
                        Text(author.authorName)
                            .subHeaderTitleViewModifier()
                        shareButton()
                    }
                    .font(.title)
                    .padding(.bottom, 15)
                }
                
                if isImageExpanded {
                    authorImageAndDatesExpanded()
                } else {
                    authorImageAndDatesCollapsed()
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        authorBook(author: author)
                        authorBio(bio: author.authorBio)
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
            }
            .font(.footnote)
            .padding(.horizontal)
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
    
    func shareButton() -> some View {
        ShareLink(
            item: author,
            subject: Text("Bookzzle Author"),
            message: Text("Check out this great author!"),
            preview: SharePreview(
                "Share \"\(author.authorName)\"",
                image: Image(uiImage: author.uAuthorPhoto)
            )
        ) {
            Image(systemName: "square.and.arrow.up.circle")
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(Circle())
        }
    }
    
    func authorImageAndDatesCollapsed() -> some View {
        HStack {
            Image(uiImage: author.uAuthorPhoto)
                .resizable()
                .matchedGeometryEffect(id: "Image", in: animation)
                .frame(width: 100, height: 100)
                .foregroundColor(Color.white)
                .background(.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .primary, radius: 2, x: 0, y: 0)
                .onTapGesture {
                    withAnimation(.bouncy()) {
                        isImageExpanded.toggle()
                    }
                }
            
            VStack {
                VStack {
                    Text("Birth Date").foregroundStyle(.secondary)
                    Text(author.authorBirthDate)
                }
                .matchedGeometryEffect(id: "Birth", in: animation)
                .frame(maxWidth: .infinity, alignment: .center)
                .detailInformationBlockViewModifier(padding: 5)
                
                VStack {
                    Text("Death Date").foregroundStyle(.secondary)
                    Text(author.authorDeathDate)
                }
                .matchedGeometryEffect(id: "Death", in: animation)
                .frame(maxWidth: .infinity)
                .detailInformationBlockViewModifier(padding: 5)
            }
        }
    }
    
    func authorImageAndDatesExpanded() -> some View {
        VStack {
            Image(uiImage: author.uAuthorPhoto)
                .resizable()
                .matchedGeometryEffect(id: "Image", in: animation)
                .frame(width: 300, height: 300)
                .foregroundColor(Color.white)
                .background(.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .primary, radius: 2, x: 0, y: 0)
                .onTapGesture {
                    withAnimation(.spring()) {
                        isImageExpanded.toggle()
                    }
                }
            
            HStack {
                VStack {
                    Text("Birth Date").foregroundStyle(.secondary)
                    Text(author.authorBirthDate)
                }
                .matchedGeometryEffect(id: "Birth", in: animation)
                .frame(maxWidth: .infinity, alignment: .center)
                .detailInformationBlockViewModifier(padding: 5)
                
                VStack {
                    Text("Death Date").foregroundStyle(.secondary)
                    Text(author.authorDeathDate)
                }
                .matchedGeometryEffect(id: "Death", in: animation)
                .frame(maxWidth: .infinity)
                .detailInformationBlockViewModifier(padding: 5)
            }
        }
    }
    
    func authorBio(bio: String) -> some View {
        VStack {
            Text("Biography")
                .detailInformationHeaderViewModifier()
            ScrollView {
                Text(bio)
                    .padding(5)
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
        }
        .frame(maxHeight: 400)
        .frame(maxWidth: .infinity)
        .detailInformationBlockViewModifier()
    }
    
    func authorBook(author: Author) -> some View {
        VStack {
            Text("Books In My Library")
                .detailInformationHeaderViewModifier()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(author.books) { book in
                        Image(uiImage: book.uCoverPhoto)
                            .imageModifier(width: 60, height: 90, bgcolor: .white)
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
        }
        .detailInformationBlockViewModifier()
    }
}

// MARK: - PREVIEW
#Preview {
    let author = Author.sampleAuthors[0]
    author.books.append(contentsOf: Book.sampleBooks[0..<3])
    
    return NavigationStack {
        AuthorDetailView(author: author)
            .preferredColorScheme(.dark)
    }
}
