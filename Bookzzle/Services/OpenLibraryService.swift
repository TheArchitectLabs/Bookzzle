//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import Foundation

enum OLEndPoint {
    case work(query: String, page: Int)
    case authorFromWork(id: String)
    case authorFromAuthor(query: String)
    case editionFromWork(key: String, limit: Int, offset: Int)
    
    var url: URL? {
        switch self {
            case .work(let query, let page):
                let baseURL = "https://openlibrary.org/search.json?"
                let languages = "&language=eng"
                let fields = "&fields=key,title,first_publish_year,first_sentence,number_of_pages_median,author_key,author_name,cover_i,cover_edition_key,isbn"
                return URL(string: baseURL + "\(query)" + languages + fields + "&page=\(page)")
            case .editionFromWork(let key, let limit, let offset):
                return URL(string: "https://openlibrary.org\(key)/editions.json?limit=\(limit)&offset=\(offset)&language=eng")
            case .authorFromWork(let id):
                return URL(string: "https://openlibrary.org/authors/\(id).json")
            case .authorFromAuthor(let query):
                return URL(string: "https://openlibrary.org/search/authors.json?q=\(query)")
        }
    }
}

@Observable
class OpenLibraryService {
    
    // MARK: - PROPERTIES
    private let decoder = JSONDecoder()
    
    // MARK: - INITIALIZER
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    public func fetchWork(query: String, page: Int) async throws -> OLWorksSearch {
        guard let url = OLEndPoint.work(query: query, page: page).url else { throw BZNotification.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw BZNotification.noNetworkAvailable }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(OLWorksSearch.self, from: data)
        } catch {
            throw BZNotification.failedToDecode
        }
    }
    
    public func fetchEdition(key: String, limit: Int, offset: Int) async throws -> [OLEditionEntry] {
        guard let url = OLEndPoint.editionFromWork(key: key, limit: limit, offset: offset).url else { throw BZNotification.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZNotification.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            let result = try decoder.decode(OLEditionsSearch.self, from: data)
            return result.entries
        } catch {
            throw BZNotification.failedToDecode
        }
    }
    
    public func fetchAuthor<T: Decodable>(query: String) async throws -> T {
        guard let url = OLEndPoint.authorFromAuthor(query: query).url else { throw BZNotification.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZNotification.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw BZNotification.failedToDecode
        }
    }
    
    public func fetchAuthor(id: String) async throws -> OLAuthor {
        guard let url = OLEndPoint.authorFromWork(id: id).url else { throw BZNotification.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZNotification.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(OLAuthor.self, from: data)
        } catch {
            throw BZNotification.failedToDecode
        }
    }
    
    public func getAppleBook(term: String) async throws -> ITunesBook {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=ebook&country=US") else {
            throw BZNotification.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZNotification.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(ITunesBook.self, from: data)
        } catch {
            throw BZNotification.failedToDecode
        }
    }

}
