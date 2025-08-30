//
//  OpenLibraryManager.swift
//  Bookzzle
//
//  Created by Michael on 8/11/25.
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
                let fields = "&fields=key,title,first_publish_year,language,first_sentence,number_of_pages_median,author_key,author_name,cover_i,cover_edition_key,ddc,isbn,lccn,edition_count,edition_key"
                return URL(string: baseURL + "\(query)" + languages + fields + "&page=\(page)")
            case .editionFromWork(let key, let limit, let offset):
                // return URL(string: "https://openlibrary.org\(key)/editions.json?limit=\(limit)&offset=\(offset)")
                return URL(string: "https://openlibrary.org\(key)/editions.json?language=eng")
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
    }
    
    public func fetchWork(query: String, page: Int) async throws -> OLWorksSearch {
        guard let url = OLEndPoint.work(query: query, page: page).url else { throw BZError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw BZError.noNetworkAvailable }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZError.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(OLWorksSearch.self, from: data)
        } catch {
            throw BZError.failedToDecode
        }
    }
    
    public func fetchEdition(key: String, limit: Int, offset: Int) async throws -> [OLEditionEntry] {
        guard let url = OLEndPoint.editionFromWork(key: key, limit: limit, offset: offset).url else { throw BZError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZError.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZError.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            let result = try decoder.decode(OLEditionsSearch.self, from: data)
            return result.entries
        } catch {
            throw BZError.failedToDecode
        }
    }
    
    public func fetchAuthor<T: Decodable>(query: String) async throws -> T {
        guard let url = OLEndPoint.authorFromAuthor(query: query).url else { throw BZError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BZError.noNetworkAvailable
        }
        
        switch httpResponse.statusCode {
            case 200...299: break
            default: throw BZError.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw BZError.failedToDecode
        }
    }
    
//    private func fetchAuthor(id: String) async throws -> OLAuthorDataModel {
//        guard let url = OLEndPoint.authorFromWork(id: id).url else { throw BZNotification.invalidURL }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw BZNotification.noNetworkAvailable
//        }
//        
//        switch httpResponse.statusCode {
//            case 200...299: break
//            default: throw BZNotification.invalidStatusCode(code: httpResponse.statusCode)
//        }
//        
//        do {
//            return try decoder.decode(OLAuthorDataModel.self, from: data)
//        } catch {
//            throw BZNotification.failedToDecode
//        }
//    }
//
}
